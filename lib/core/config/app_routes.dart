import 'package:flutter/material.dart';
import 'package:news_app/core/config/page_route_name.dart';
import 'package:news_app/modules/all_cubits/articals_cubit/view/news_web_view.dart';
import 'package:news_app/modules/view/sceens/home_Screen.dart';
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
      case PageRouteName.webSceen:
        return MaterialPageRoute(
          builder: (context) {
            return NewsWebView(url: setting.arguments as String);
          },
        );

      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}
