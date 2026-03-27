import 'package:fitlife/components/color.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String customTextTwo;
  final Future<void> Function()? onTap; // ✅ allows async functions too

  const Buttons({super.key, required this.customTextTwo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.buttonColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap == null
          ? null
          : () async {
              await onTap!(); // ✅ supports async functions
            },
      child: Center(
        child: Text(
          customTextTwo,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
