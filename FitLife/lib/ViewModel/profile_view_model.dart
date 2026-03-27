import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/repo/profile_repo.dart';

class ProfileViewModel extends GetxController {
  final ProfileRepo repo;
  ProfileViewModel(this.repo);

  final RxnString imageUrl = RxnString(); // nullable observable
  final RxBool isUploading = false.obs;
  final RxnString error = RxnString();

  StreamSubscription? _sub;
  StreamSubscription<User?>? _authSub;

  @override
  void onInit() {
    super.onInit();

    // Listen to auth state changes
    _authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
      _sub?.cancel();
      _sub = null;

      if (user == null) {
        imageUrl.value = null;
      } else {
        _sub = repo.streamProfile().listen((snapshot) {
          final url = snapshot.data()?['imageUrl'] as String?;
          imageUrl.value = url;
        }, onError: (e) => error.value = e.toString());
      }
    });
  }

  @override
  void onClose() {
    _sub?.cancel();
    _authSub?.cancel();
    super.onClose();
  }

  Future<void> pickAndUpload(ImageSource source) async {
    try {
      error.value = null;

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        error.value = 'Please sign in to update your profile.';
        return;
      }

      final picker = ImagePicker();
      final picked = await picker.pickImage(source: source, imageQuality: 80);
      if (picked == null) return;

      final file = File(picked.path);
      isUploading.value = true;

      final uploadedUrl = await repo.uploadProfile(file);
      if (uploadedUrl == null) {
        error.value = 'Image upload failed.';
        return;
      }

      imageUrl.value = uploadedUrl;

      try {
        await repo.saveImageUrl(uploadedUrl);
      } catch (e) {
        error.value = 'Uploaded but failed to save to Firestore: $e';
        print('[ProfileViewModel] saveImageUrl error: $e');
      }
    } catch (e, st) {
      error.value = e.toString();
      print('[ProfileViewModel] pickAndUpload error: $e\n$st');
    } finally {
      isUploading.value = false;
    }
  }
}
