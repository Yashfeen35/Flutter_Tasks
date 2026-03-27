import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitlife/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait until the first frame is drawn, THEN start timer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        if (mounted) {
          // Use GetX routing to go to onboarding
          Get.offNamed(Routes.onboarding);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/splash_screen.png',
          // fit: BoxFit.cover,
          height: double.infinity,
          // width: double.infinity,
        ),
      ),
    );
  }
}
