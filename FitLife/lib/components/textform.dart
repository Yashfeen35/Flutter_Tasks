import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboard;
  final String hintText;
  final Widget? suffixicon;
  final bool obscureText; // 👈 Added this

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboard,
    required this.hintText,
    this.suffixicon,
    this.obscureText = false, // 👈 Default is false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscureText, // 👈 Added here
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        suffixIcon: suffixicon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
        ),
      ),
    );
  }
}
