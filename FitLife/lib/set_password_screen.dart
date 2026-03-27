import 'package:fitlife/components/buttons.dart';
import 'package:fitlife/components/text.dart';
import 'package:fitlife/components/textform.dart';
import 'package:fitlife/routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SetPasswordScreen extends StatefulWidget {
  static const String id = "set_password_screen";
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                text: "Set Password",
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 40.0),

            CustomText(
              text: "Password",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 6.0),

            /// ✅ Using your custom TextformField
            CustomTextFormField(
              keyboard: TextInputType.text,
              hintText: "Enter password",
              controller: passwordController,
              suffixicon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() => passwordVisible = !passwordVisible);
                },
              ),
            ),

            const SizedBox(height: 20.0),

            CustomText(
              text: "Confirm Password",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 6.0),

            /// ✅ Using your custom TextformField again
            CustomTextFormField(
              keyboard: TextInputType.text,
              hintText: "Confirm password",
              controller: confirmPasswordController,
              suffixicon: IconButton(
                icon: Icon(
                  confirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(
                    () => confirmPasswordVisible = !confirmPasswordVisible,
                  );
                },
              ),
            ),

            const SizedBox(height: 25.0),

            Buttons(
              customTextTwo: "Sign In",
              onTap: () async {
                Get.toNamed(Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
