import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

ThemeData appTheme() {
  final ThemeData base = ThemeData.dark();

  AppBarTheme _appBarTheme(AppBarTheme base) {
    return base.copyWith(
      color: AppColors.invis,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold
      )
    );
  }

  FloatingActionButtonThemeData _floatingActionButtonTheme(FloatingActionButtonThemeData base) {
    return base.copyWith(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
    );
  }

  return base.copyWith(
    appBarTheme: _appBarTheme(base.appBarTheme),
    floatingActionButtonTheme: _floatingActionButtonTheme(base.floatingActionButtonTheme)
  );
}