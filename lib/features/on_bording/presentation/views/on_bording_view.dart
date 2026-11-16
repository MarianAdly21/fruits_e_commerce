import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:fruits_e_commerce/constant.dart';
import 'package:fruits_e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:fruits_e_commerce/core/widgets/app_text_button.dart';
import 'package:fruits_e_commerce/features/auth/presentation/views/login_view.dart';
import 'package:fruits_e_commerce/features/on_bording/presentation/views/widgets/on_bording_page_view.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class OnBordingView extends StatefulWidget {
  const new({super.key});
  static const String routeName = "/on-bording";

  @override
  State<OnBordingView> createState() => _OnBordingViewState();
}

class _OnBordingViewState extends State<OnBordingView> {
  late PageController pageController;
  int currentPage = 0;
  @override
  void initState() {
    pageController = PageController();

    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: OnBordingPageView(controller: pageController)),
            DotsIndicator(
              dotsCount: 2,
              position: currentPage.toDouble(),
              animate: true,
              decorator: DotsDecorator(
                color: currentPage == 1
                    ? AppColor.activeDotsIndecatorOnBording
                    : AppColor.dotsIndecatorColorOnBording.withValues(
                        alpha: 0.5,
                      ),
                activeColor: AppColor.activeDotsIndecatorOnBording,
                size: currentPage == 1 ? const Size(11, 11) : const Size(9, 9),
                activeSize: const Size(11, 11),
              ),
            ),
            Visibility(
              visible: currentPage == 1 ? true : false,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 29.h),
                child: AppTextButton(
                  onPressed: () {
                   Prefs.setBool(kIsOnBordingViewSeen, true);
                    Navigator.of(context)
                        .pushReplacementNamed(LoginView.routeName);
                  },
                  text: "ابدأ الان",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
