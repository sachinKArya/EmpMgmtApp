import 'package:employee_management/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFormField extends StatelessWidget {
  final String prefixIconName;
  final String hintName;
  final TextEditingController controller;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Widget? suffixWidget;

  CustomTextFormField({
    super.key,
    required this.prefixIconName,
    required this.hintName,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.suffixWidget,
  });

  final textFieldOutline = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
      borderRadius: BorderRadius.all(Radius.circular(4.r)));

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: readOnly!,
      style: TextStyle(color: inputTextColor, fontSize: 16.sp),
      decoration: InputDecoration(
        enabledBorder: textFieldOutline,
        focusedBorder: textFieldOutline,
        border: textFieldOutline,
        hintText: hintName,
        prefixIconConstraints: BoxConstraints(
          maxHeight: 24.h,
          minWidth: 44.w,
        ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 24.h,
          minWidth: 44.w,
        ),
        contentPadding: EdgeInsets.zero,
        hintStyle: TextStyle(color: hintColor, fontSize: 16.sp),
        prefixIcon: SvgPicture.asset(
          'assets/icons/$prefixIconName',
          height: 24.h,
          width: 24.w,
        ),
        suffixIcon: suffixWidget,
      ),
    );
  }
}
