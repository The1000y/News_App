import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/core/config/page_route_name.dart';
import 'package:news_app/core/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        PageRouteName.homeScreen,
        (route) => false,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Assets.images.splashScreen.image(fit: BoxFit.cover);
  }
}
