import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_e_commerce/res/app_assets.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class CustomCheckBoxWidget extends StatelessWidget {
  const new({super.key, required this.isChecked,required this.onChanged});
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       onChanged(!isChecked);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 24.w,
        height: 24.h,
        decoration: ShapeDecoration(
          color: isChecked ? AppColor.primaryColor : AppColor.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isChecked
                  ? AppColor.transparentColor
                  : AppColor.buttonBorderColor,
              width: 1.5,
            ),
          ),
        ),
        child: isChecked
            ? Padding(
                padding: const EdgeInsets.all(2),
                child: SvgPicture.asset(AppAssets.checkIcon),
              )
            : null,
      ),
    );
  }
}
