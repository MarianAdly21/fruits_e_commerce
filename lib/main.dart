import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:fruits_e_commerce/core/helper/on_generate_routes.dart';
import 'package:fruits_e_commerce/core/services/custom_bloc_observer.dart';
import 'package:fruits_e_commerce/core/services/git_it_sevice.dart';
import 'package:fruits_e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:fruits_e_commerce/features/splash/presentation/views/splash_view.dart';
import 'package:fruits_e_commerce/firebase_options.dart';
import 'package:fruits_e_commerce/res/app_color.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Prefs.init();
  setup();
  Bloc.observer = CustomBlocObserver();
   await GoogleSignIn.instance.initialize(
    serverClientId: "30687210253-sgbr8v64rvoodlbaa88gil8ii2e52gda.apps.googleusercontent.com"
  );
  runApp(const FruitHub());
}

class FruitHub extends StatelessWidget {
  const FruitHub({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: AppColor.scaffoldBg,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
        ),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale("ar"),
        onGenerateRoute: onGenerateRoute,
        initialRoute: SplashView.routeName,
        home: SplashView(),
      ),
    );
  }
}
