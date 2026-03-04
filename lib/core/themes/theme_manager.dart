import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/themes/color_pallete.dart';

abstract class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: AppColors.whiteColor,
    primaryColorDark: AppColors.darkColor,
    primaryColorLight: AppColors.whiteColor,

    scaffoldBackgroundColor: AppColors.whiteColor,
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.darkColor,
      ),
      titleMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppColors.darkColor,
      ),
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.darkColor,
      ),
      bodySmall: TextStyle(fontSize: 14, color: Colors.grey),
    ),

    appBarTheme: AppBarThemeData(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColorDark: AppColors.whiteColor,
    primaryColorLight: AppColors.darkColor,
    primaryColor: AppColors.darkColor,
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
      titleMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
      ),
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: AppColors.darkColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
      ),
      bodySmall: TextStyle(fontSize: 14, color: Colors.grey),
    ),

    scaffoldBackgroundColor: AppColors.darkColor,
    appBarTheme: AppBarThemeData(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.darkColor,
      centerTitle: true,
    ),
  );
}
