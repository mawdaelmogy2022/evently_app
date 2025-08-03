import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lighttheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColor.whiteColor,
        unselectedItemColor: AppColor.whiteColor,
        showUnselectedLabels: true,
        selectedLabelStyle: AppStyle.white12bold),
    primaryColor: AppColor.primaryblueColor,
    focusColor: AppColor.whiteColor,
    cardColor: AppColor.whiteColor,
    canvasColor: AppColor.blackColor,
    textTheme: TextTheme(
        headlineLarge: AppStyle.black20bold,
        headlineMedium: AppStyle.blue14bold,
        headlineSmall: AppStyle.black14bold,
        titleMedium: AppStyle.blue14bold,
        titleLarge: AppStyle.black16meduim),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryblueColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: AppColor.whiteColor, width: 4)),
    ),
    scaffoldBackgroundColor: AppColor.whiteColor,
  );
  static final ThemeData darktheme = ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //elevation: 0,
          selectedItemColor: AppColor.whiteColor,
          unselectedItemColor: AppColor.whiteColor,
          showUnselectedLabels: true,
          selectedLabelStyle: AppStyle.white12bold),
      primaryColor: AppColor.primaryblueblackColor,
      focusColor: AppColor.primaryblueColor,
      cardColor: AppColor.primaryblueblackColor,
      canvasColor: AppColor.whiteColor,
      textTheme: TextTheme(
        headlineLarge: AppStyle.white20bold,
        headlineMedium: AppStyle.blueblack14bold,
        headlineSmall: AppStyle.white14bold,
        titleMedium: AppStyle.white14bold,
        titleLarge: AppStyle.white16meduim,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.primaryblueblackColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: AppColor.whiteColor, width: 4)),
      ),
      scaffoldBackgroundColor: AppColor.primaryblueblackColor);
}
