import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class RichTextCustomWidget extends StatelessWidget {
  const new({super.key,required this.onTap, required this.text1,required this.text2});
final void Function()? onTap;
final String text1 ;
final String text2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColor.smallTextColor,
        ),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: text2,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
