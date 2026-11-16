import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_e_commerce/constant.dart';
import 'package:fruits_e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:fruits_e_commerce/features/auth/presentation/views/login_view.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class PageViewItem extends StatelessWidget {
  const new({
    super.key,
    required this.image,
    required this.backgroundImage,
    required this.subTitle,
    required this.title,
    required this.isVisible,
  });
  final String image, backgroundImage;
  final String subTitle;
  final Widget title;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              children: [
                Positioned.fill(
                  child: SvgPicture.asset(backgroundImage, fit: BoxFit.fill),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: SvgPicture.asset(image),
                ),
                isVisible
                    ? TextButton(
                        onPressed: () {
                          Prefs.setBool(kIsOnBordingViewSeen, true);

                          Navigator.of(context)
                              .pushReplacementNamed(LoginView.routeName);
                        },
                        child: Text(
                          "تخط",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColor.skipTextOnBording,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),

        _titleAndSubTitleWidget(),
      ],
    );
  }

  Widget _titleAndSubTitleWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 64.h, horizontal: 37.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          title,
          SizedBox(height: 24.h),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColor.subTitleTextOnBording,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
