import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

ThemeData appTheme() {
  final ThemeData base = ThemeData.dark();

  AppBarTheme _appBarTheme(AppBarTheme base) {
    return base.copyWith(
      centerTitle: true,
      backgroundColor: AppColors.darkGrey,
      elevation: 10,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24
      )
    );
  }

  FloatingActionButtonThemeData _floatingActionButtonTheme(FloatingActionButtonThemeData base) {
    return base.copyWith(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
    );
  }

  BottomNavigationBarThemeData _bottomNavigationBarTheme(BottomNavigationBarThemeData base) {
    return base.copyWith(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: AppColors.magenta,
      unselectedItemColor: AppColors.grey,
    );
  }

  return base.copyWith(
    appBarTheme: _appBarTheme(base.appBarTheme),
    floatingActionButtonTheme: _floatingActionButtonTheme(base.floatingActionButtonTheme),
    bottomNavigationBarTheme: _bottomNavigationBarTheme(base.bottomNavigationBarTheme)
  );
}