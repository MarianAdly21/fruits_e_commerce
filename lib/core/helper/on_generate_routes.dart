import 'package:flutter/material.dart';
import 'package:fruits_e_commerce/features/auth/presentation/views/login_view.dart';
import 'package:fruits_e_commerce/features/on_bording/presentation/views/on_bording_view.dart';
import 'package:fruits_e_commerce/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => SplashView());
    case OnBordingView.routeName:
      return MaterialPageRoute(builder: (context) => OnBordingView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => LoginView());

    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
