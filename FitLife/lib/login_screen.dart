import 'package:fitlife/components/buttons.dart';
import 'package:fitlife/components/text.dart';
import 'package:fitlife/components/textform.dart';
import 'package:fitlife/routes.dart';
import 'package:fitlife/sign_up.dart';
import 'package:fitlife/set_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitlife/ViewModel/auth/LoginVM.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late final LoginVM _loginVM;

  @override
  void initState() {
    super.initState();
    // The LoginVM is provided via InitialBindings; retrieve it here
    if (Get.isRegistered<LoginVM>()) {
      _loginVM = Get.find<LoginVM>();
    } else {
      // fallback: register locally so the screen still works
      _loginVM = Get.put(LoginVM());
    }

    // react to errors -> show snackbars
    ever(_loginVM.errorMessage, (String? msg) {
      if (msg != null && msg.isNotEmpty) {
        Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
      }
    });

    // react to successful login -> navigate
    ever(_loginVM.isLoggedIn, (bool loggedIn) {
      if (loggedIn) {
        Get.offAllNamed(Routes.home);
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 130.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  text: "Sign In",
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40.0),

              CustomText(
                text: "Email Address",
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              const SizedBox(height: 6.0),

              CustomTextFormField(
                controller: emailController,
                keyboard: TextInputType.emailAddress,
                hintText: "Enter email address",
              ),

              const SizedBox(height: 20.0),

              CustomText(
                text: "Password",
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              const SizedBox(height: 6.0),

              Obx(
                () => CustomTextFormField(
                  controller: passwordController,
                  keyboard: TextInputType.visiblePassword,
                  hintText: "Enter password",
                  obscureText: _loginVM.isPasswordHidden.value,
                  suffixicon: IconButton(
                    icon: Icon(
                      _loginVM.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _loginVM.togglePassword,
                  ),
                ),
              ),

              const SizedBox(height: 10.0),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.setPassword);
                  },
                  child: CustomText(
                    text: "Forgot Password?",
                    fontSize: 12.0,
                    color: Colors.red,
                  ),
                ),
              ),

              const SizedBox(height: 25.0),

              Obx(
                () => Buttons(
                  customTextTwo: _loginVM.isLoading.value
                      ? 'Loading...'
                      : 'Sign In',
                  onTap: _loginVM.isLoading.value
                      ? null
                      : () => _loginVM.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        ),
                ),
              ),

              const SizedBox(height: 20.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Don’t have an account? ",
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.signup),
                    child: CustomText(
                      text: "Create Account",
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF26215D),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25.0),

              Center(
                child: CustomText(
                  text: "Or",
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 25.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon("assets/google.png"),
                  const SizedBox(width: 15.0),
                  _socialIcon("assets/apple.png"),
                  const SizedBox(width: 15.0),
                  _socialIcon("assets/facebook.png"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(String path) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        shape: BoxShape.circle,
      ),
      child: Image.asset(path),
    );
  }
}
