import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:fitlife/data/Repo/AuthRepo.dart';

class LoginVM extends GetxController {
  // MVVM-friendly observables
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final errorMessage = RxnString();
  final isLoggedIn = false.obs;

  final AuthRepo _repo;

  // Accept injected AuthRepo; fallback to Get.find
  LoginVM({AuthRepo? repo}) : _repo = repo ?? Get.find<AuthRepo>();

  void togglePassword() => isPasswordHidden.value = !isPasswordHidden.value;

  // Performs validation + login. Does NOT perform navigation or show snackbars.
  Future<void> login(String email, String password) async {
    // Validate
    if (email.isEmpty) {
      errorMessage.value = "Email cannot be empty";
      return;
    }

    if (!GetUtils.isEmail(email)) {
      errorMessage.value = "Please enter a valid email address";
      return;
    }

    if (password.isEmpty) {
      errorMessage.value = "Password cannot be empty";
      return;
    }

    if (password.length < 6) {
      errorMessage.value = "Password must be at least 6 characters long";
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = null;

      await _repo.login(email, password);

      isLoading.value = false;
      isLoggedIn.value = true; // View observes this and navigates
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      errorMessage.value = e.message ?? 'Authentication failed';
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Something went wrong';
    }
  }
}
