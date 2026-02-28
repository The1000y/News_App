import 'package:flutter/material.dart';
import 'package:news_app/core/themes/color_pallete.dart';

abstract class ThemeManager {
  static ThemeData getLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorPallete.scafoldBackgroundColor,
      appBarTheme: AppBarThemeData(
        scrolledUnderElevation: 0,
        backgroundColor: ColorPallete.scafoldBackgroundColor,
        centerTitle: true,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData();
  }
}
