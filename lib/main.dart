import 'package:flutter/material.dart';
import 'package:news_app/core/config/app_routes.dart';
import 'package:news_app/core/themes/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getLightTheme(),
      themeMode: ThemeMode.system,
      onGenerateRoute: AppRoute.onGenerateRoute,
      
    );
  }
}
