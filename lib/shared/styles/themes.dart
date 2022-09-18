import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: mainColor,
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: mainColor),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: mainColor),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[300],
        statusBarIconBrightness: Brightness.dark),
    elevation: 0.0,
    color: Colors.white,
    titleTextStyle: const TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
    iconTheme: const IconThemeData(
      color: mainColor,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: mainColor,
    unselectedItemColor: Colors.blueGrey,
  ),
  scaffoldBackgroundColor: Colors.white,
);

ThemeData darkTheme = ThemeData(
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: mainColor),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: mainColor),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[300],
        statusBarIconBrightness: Brightness.dark),
    elevation: 0.0,
    color: Colors.white,
    titleTextStyle: const TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
    iconTheme: const IconThemeData(
      color: mainColor,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: mainColor,
    unselectedItemColor: Colors.blueGrey,
  ),
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: mainColor,
);
