import 'package:fitlife/components/buttons.dart';
import 'package:fitlife/components/text.dart';
import 'package:fitlife/components/textform.dart';
import 'package:fitlife/login_screen.dart';
import 'package:fitlife/routes.dart';
import 'package:fitlife/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitlife/ViewModel/auth/SignUpVM.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "signup_screen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final SignUpVM _vm;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signUpUser() async {
    // Use VM for registration (ViewModel handles validation and repo calls)
    await _vm.register(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text,
    );
  }

  Widget _socialIcon(String assetPath) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        shape: BoxShape.circle,
      ),
      child: Image.asset(assetPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  text: "Sign Up",
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 40.0),

              CustomText(
                text: "Full Name",
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              const SizedBox(height: 6.0),

              CustomTextFormField(
                keyboard: TextInputType.text,
                hintText: "Enter full name",
                controller: nameController,
              ),

              const SizedBox(height: 20.0),

              CustomText(
                text: "Email Address",
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              const SizedBox(height: 6.0),

              CustomTextFormField(
                keyboard: TextInputType.emailAddress,
                hintText: "Enter email address",
                controller: emailController,
              ),

              const SizedBox(height: 20.0),

              CustomText(
                text: "Password",
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              const SizedBox(height: 6.0),

              Obx(
                () => CustomTextFormField(
                  controller: passwordController,
                  keyboard: TextInputType.visiblePassword,
                  hintText: "Enter password",
                  obscureText: _vm.isPasswordHidden.value,
                  suffixicon: IconButton(
                    icon: Icon(
                      _vm.isPasswordHidden.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: _vm.togglePassword,
                  ),
                ),
              ),

              const SizedBox(height: 25.0),

              Obx(
                () => Buttons(
                  customTextTwo: _vm.isLoading.value
                      ? "Creating..."
                      : "Continue",
                  onTap: _vm.isLoading.value ? null : _signUpUser,
                ),
              ),

              const SizedBox(height: 20.0),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Already have an account? ",
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.login),
                      child: CustomText(
                        text: "Sign In",
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF26215D),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25.0),

              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey.shade300, thickness: 1),
                  ),
                  const SizedBox(width: 10.0),
                  Center(
                    child: CustomText(
                      text: "Or",
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Divider(color: Colors.grey.shade300, thickness: 1),
                  ),
                ],
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // get the SignUpVM that InitialBindings registered (fallback to local)
    if (Get.isRegistered<SignUpVM>()) {
      _vm = Get.find<SignUpVM>();
    } else {
      _vm = Get.put(SignUpVM());
    }

    ever(_vm.errorMessage, (String? msg) {
      if (msg != null && msg.isNotEmpty) {
        Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
      }
    });

    ever(_vm.isSignedUp, (bool s) {
      if (s) {
        Get.toNamed(Routes.success);
      }
    });
  }
}
