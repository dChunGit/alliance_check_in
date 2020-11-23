import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSizes {
  static const int splashScreenTitleFontSize = 48;
  static const int titleFontSize = 34;
  static const double sidePadding = 15;
  static const double widgetSidePadding = 20;
  static const double buttonRadius = 25;
  static const double imageRadius = 8;
  static const double linePadding = 4;
  static const double widgetBorderRadius = 34;
  static const double textFieldRadius = 4.0;
  static const EdgeInsets bottomSheetPadding = EdgeInsets.symmetric(
      horizontal: 16, vertical: 10);
  static const app_bar_size = 56.0;
  static const app_bar_expanded_size = 180.0;
  static const tile_width = 148.0;
  static const tile_height = 276.0;
}

class AppColors {
  static const primaryColor = Color(0xFF3c78af);
  static const darkTextColor = Color(0xFFF7F4F3);
  static const lightTextColor = Color(0xFF0b1a2b);
  static const darkTextColorAccent = Color(0xFFEAF2EF);

  static const backgroundColor = Color(0xFF153151);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const accent = Color(0xFF3399ff);

  static const toggleSelected = primaryColor;
  static const toggleDeselected = Color(0xDD9B9B9B);

  static const headerColor = Color(0xFF00558c);

  static const headline = Color(0xFF4d4d4d);

  // Status colors
  static const error = Color(0xffF58232);

  // Misc colors
  static const toastColor = Color(0xDD9B9B9B);
}

class AllianceTheme {
  static ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: AppColors.primaryColor,
      primaryColorLight: AppColors.lightTextColor,
      accentColor: AppColors.accent,
      backgroundColor: AppColors.backgroundColor,
      errorColor: AppColors.error,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,

      textTheme: GoogleFonts.karlaTextTheme(theme.textTheme.copyWith(
        headline1: theme.textTheme.headline1.copyWith(
            fontWeight: FontWeight.w500),
        headline2: theme.textTheme.headline2.copyWith(
            color: AppColors.lightTextColor,
            fontSize: 48),
        headline3: theme.textTheme.headline3.copyWith(
            color: AppColors.lightTextColor,
            fontWeight: FontWeight.w400),
        headline4: theme.textTheme.headline4.copyWith(
            color: AppColors.lightTextColor,
            fontSize: 24,
            fontWeight: FontWeight.w600),
        headline5: theme.textTheme.headline5.copyWith(
            fontSize: 18,
            color: AppColors.lightTextColor,
            fontWeight: FontWeight.w900),
        headline6: theme.textTheme.headline6.copyWith(
            fontSize: 16,
            color: AppColors.lightTextColor,
            fontWeight: FontWeight.w900),

        subtitle1: theme.textTheme.subtitle1.copyWith(
            fontSize: 24,
            color: AppColors.lightTextColor,
            fontWeight: FontWeight.w500),
        subtitle2: theme.textTheme.subtitle2.copyWith(
            fontSize: 18,
            color: AppColors.lightTextColor,
            fontWeight: FontWeight.w400),

        button: theme.textTheme.button.copyWith(
            fontSize: 14,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500),

        caption: theme.textTheme.caption.copyWith(
            fontSize: 16,
            color: AppColors.lightTextColor,
            fontWeight: FontWeight.normal),


        bodyText1: theme.textTheme.bodyText1.copyWith(
            color: AppColors.lightTextColor,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        bodyText2: theme.textTheme.bodyText2.copyWith(
            color: AppColors.lightTextColor,
            fontSize: 11,
            fontWeight: FontWeight.normal),
      )),
    );
  }
}
