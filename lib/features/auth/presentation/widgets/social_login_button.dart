import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class SocialLoginButton extends StatelessWidget {
  const new({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.padding,
  });
  final VoidCallback onPressed;
  final String text;
  final String icon;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: 16.h),
      child: SizedBox(
        height: 56.h,
        width: double.infinity,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: AppColor.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColor.buttonBorderColor),
            ),
          ),
          child: ListTile(
            visualDensity: VisualDensity(
              vertical: VisualDensity.minimumDensity,
            ),
            leading: SvgPicture.asset(icon),
            title: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.blackFont,
              ),
            ),
          ),
          // Row(
          //   children: [
          //     IconButton(onPressed: onPressed, icon: SvgPicture.asset(icon)),
          //     Text(
          //       text,
          //       style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold,
          //         color: AppColor.blackFont,
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
