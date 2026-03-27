import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final fontWeight;
  final fontSize;
  final color;
  final textAlign;
  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight,
    required this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
