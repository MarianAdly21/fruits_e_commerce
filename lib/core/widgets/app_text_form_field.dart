import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class AppTextFormField extends StatefulWidget {
  const new({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.obscureText = false,
    this.controller,
    this.validator,
  });
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isObscure = false;
  bool setObscure = false;

  @override
  Widget build(BuildContext context) {
    if (!setObscure) {
      isObscure = widget.obscureText;
      setObscure = true;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        cursorColor: AppColor.blackFont,
        obscureText: isObscure,
        obscuringCharacter: '●',
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.textInputType,
        style: TextStyle(
          fontSize: 16,
          color: AppColor.blackFont,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 13,
            color: AppColor.hintText,
            fontWeight: FontWeight.w700,
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColor.hintText,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: AppColor.textFieldFillColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
          border: _outlineInputBorder(),
          enabledBorder: _outlineInputBorder(),
          focusedBorder: _outlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColor.textFieldBorderColor, width: 1),
    );
  }
}
