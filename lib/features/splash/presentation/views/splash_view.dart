import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_e_commerce/features/on_bording/presentation/views/on_bording_view.dart';
import 'package:fruits_e_commerce/res/app_assets.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class SplashView extends StatefulWidget {
  const new({super.key});
  static const String routeName = "/splash";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    /// to start time to switch to another screen
    _startTime();
  }

  Future<Timer> _startTime() async {
    final duration = const Duration(milliseconds: 2000);
    return Timer(
      duration,
      () => Navigator.pushReplacementNamed(context, OnBordingView.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: SvgPicture.asset(AppAssets.plant),
          ),
          SvgPicture.asset(AppAssets.appLogo),
          SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(AppAssets.splashBottom),
          ),
        ],
      ),
    );
  }
}
