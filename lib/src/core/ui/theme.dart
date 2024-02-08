import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

final themeData = ThemeData(
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: AppColors.mainBlack),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundWhite,
    shadowColor: Colors.black.withOpacity(0.3),
    surfaceTintColor: Colors.transparent,
    elevation: 1,
  ),
  fontFamily: kDefaultFontFamily,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      color: AppColors.mainBlack,
    ),
    displayLarge: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: AppColors.mainBlack,
    ),
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColors.blue,
    ),
    displayMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.mainBlack,
    ),
    displaySmall: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.mainBlack,
    ),
    bodySmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: AppColors.mainBlack,
    ),
  ),
  scaffoldBackgroundColor: AppColors.backgroundWhite,
  colorScheme: const ColorScheme.light().copyWith(background: AppColors.white),
  // primaryColor: AppColors.mainBlack,
  bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.backgroundWhite),
);
