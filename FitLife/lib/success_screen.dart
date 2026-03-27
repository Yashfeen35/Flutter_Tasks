import 'package:fitlife/components/buttons.dart';
import 'package:fitlife/components/text.dart';
import 'package:fitlife/routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  static const String id = "success_screen";
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          children: [
            const SizedBox(height: 100.0),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 90),

                  const SizedBox(height: 20.0),

                  CustomText(
                    text: "Your account has been successfully created",
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    color: Colors.black,
                  ),
                ],
              ),
            ),

            Buttons(
              customTextTwo: "Set Your Profile",
              onTap: () async {
                Get.toNamed(Routes.personalInfo);
                return;
              },
            ),

            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
