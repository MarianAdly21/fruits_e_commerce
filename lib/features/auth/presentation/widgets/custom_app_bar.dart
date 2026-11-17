import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_e_commerce/res/app_assets.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const new({
    super.key,
    required this.title,
    this.actions,
    required this.onTap,
  });
  final List<Widget>? actions;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColor.whiteColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      actionsPadding: EdgeInsetsDirectional.only(start: 16.w),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: AppColor.blackFont,
        ),
      ),
      leading: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          bottom: 11.h,
          top: 11.h,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: SvgPicture.asset(AppAssets.backIcon),
        ),
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
