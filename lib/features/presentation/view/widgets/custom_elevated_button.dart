
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final String buttonText;
  final Size minimumSize;
  final double radius;

  const CustomElevatedButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    required this.buttonText, required this.minimumSize, required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        backgroundColor: backgroundColor,
        minimumSize: minimumSize,
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 14.sp, color: textColor),
      ),
    );
  }
}