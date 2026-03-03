import 'package:flutter/material.dart';
import 'package:news_app/core/config/page_route_name.dart';
import 'package:news_app/modules/view/home_Screen.dart';
import 'package:news_app/modules/view/splash/splash_Screen.dart';

class AppRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case PageRouteName.initialSceen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SplashScreen();
          },
        );
      case PageRouteName.homeScreen:
        return MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        );

      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}
