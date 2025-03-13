import 'package:depenses/utils/colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    fontFamily: 'Lato',
    brightness: Brightness.light,
    primaryColor: AppColor.primaryColor,
    colorScheme: const ColorScheme.light(
      primary: AppColor.primaryColor,
      secondary: AppColor.secondaryColor,
      surface: AppColor.backgroundColor,
    ),
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(fontWeight: FontWeight.w300), // Texte principal en Light
      bodyMedium:
          TextStyle(fontWeight: FontWeight.w300), // Texte secondaire en Light
      displayLarge: TextStyle(fontWeight: FontWeight.w700),
      titleLarge: TextStyle(color: AppColor.textColor),
      labelSmall: TextStyle(color: AppColor.textColor),
      headlineMedium: TextStyle(color: AppColor.lightTextColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColor.buttonLightColor,
      disabledColor: AppColor.buttonDarkColor,
    ));

class AppColors {}

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColor.primaryColor,
      secondary: AppColor.secondaryColor,
      surface: Color.fromARGB(255, 39, 39, 39),
    ),
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(fontWeight: FontWeight.w300), // Texte principal en Light
      bodyMedium:
          TextStyle(fontWeight: FontWeight.w300), // Texte secondaire en Light
      displayLarge: TextStyle(fontWeight: FontWeight.w700),
      titleLarge: TextStyle(color: AppColor.darkTextColor),
      labelSmall: TextStyle(color: AppColor.darkTextColor),
      headlineMedium: TextStyle(color: AppColor.darkTextColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColor.buttonDarkColor,
      disabledColor: AppColor.buttonDarkColor,
    ));
