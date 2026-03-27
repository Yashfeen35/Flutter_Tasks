// Simple SignUp ViewModel following MVVM + GetX
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:fitlife/data/Repo/AuthRepo.dart';

class SignUpVM extends GetxController {
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final errorMessage = RxnString();
  final isSignedUp = false.obs;

  final AuthRepo _repo;

  // Accept injected AuthRepo for dependency injection; fallback to Get.find
  SignUpVM({AuthRepo? repo}) : _repo = repo ?? Get.find<AuthRepo>();

  void togglePassword() => isPasswordHidden.value = !isPasswordHidden.value;

  Future<void> register(String name, String email, String password) async {
    // Basic validation
    if (name.trim().isEmpty) {
      errorMessage.value = 'Name cannot be empty';
      return;
    }

    if (email.trim().isEmpty) {
      errorMessage.value = 'Email cannot be empty';
      return;
    }

    if (!GetUtils.isEmail(email)) {
      errorMessage.value = 'Please enter a valid email address';
      return;
    }

    if (password.isEmpty) {
      errorMessage.value = 'Password cannot be empty';
      return;
    }

    if (password.length < 6) {
      errorMessage.value = 'Password must be at least 6 characters long';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = null;

      await _repo.register(email, password);

      isLoading.value = false;
      isSignedUp.value = true;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
        errorMessage.value = 'Your password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage.value = 'This email is already registered.';
      } else if (e.code == 'invalid-email') {
        errorMessage.value = 'Please enter a valid email address.';
      } else {
        errorMessage.value = e.message ?? 'Registration failed';
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Something went wrong';
    }
  }
}
