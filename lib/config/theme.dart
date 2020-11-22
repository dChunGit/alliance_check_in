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
  static const primaryColor = Color(0xFF0080ff);
  static const darkTextColor = Color(0xFFF7F4F3);
  static const lightTextColor = Color(0xFF0b1a2b);
  static const darkTextColorAccent = Color(0xFFEAF2EF);

  static const backgroundColor = Color(0xFF153151);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const backgroundOutline = Color(0xFF9B9B9B);
  static const accent = Color(0xFF3399ff);
  static const icons = Color(0xFFEAF2EF);
  static const iconsAlt = Color(0xFF222222);

  static const headerColor = Color(0xFF0b1a2b);
  static const defaultStatusBarColor = Color(0xFFFFFFFF);
  static const tintedStatusBarColor = Color(0xAA9B9B9B);

  static const headline = Color(0xFF005b96);
  static const headlineAlt = Color(0xffffa070);
  static const headlineAlt2 = Color(0xFF0b1a2b);
  static const headlineAlt3 = Color(0xFF4d4d4d);
  static const emailChip = Color(0xFF153151);

  // Status colors
  static const goodStatus = Color(0xFF005b96);
  static const okStatus = Color(0xffffa070);
  static const badStatus = Color(0xFFe54b4b);
  static const error = okStatus;
  static const info = Color(0xFFffb691);

  // Misc colors
  static const toastColor = Color(0xDD9B9B9B);

  static const red = Color(0xFFDB3022);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF979797);
  static const white = Color(0xFFFFFFFF);
  static const orange = Color(0xFFFFBA49);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const green = Color(0xFF2AA952);
}

class AllianceTheme {
  static ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: AppColors.primaryColor,
      primaryColorLight: AppColors.lightGray,
      accentColor: AppColors.accent,
      backgroundColor: AppColors.backgroundColor,
      errorColor: AppColors.red,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,

      textTheme: GoogleFonts.latoTextTheme(theme.textTheme.copyWith(
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
            color: AppColors.white,
            fontWeight: FontWeight.w500),
        subtitle2: theme.textTheme.subtitle2.copyWith(
            fontSize: 18,
            color: AppColors.white,
            fontWeight: FontWeight.w400),

        button: theme.textTheme.button.copyWith(
            fontSize: 14,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500),

        caption: theme.textTheme.caption.copyWith(
            fontSize: 34,
            color: AppColors.black,
            fontWeight: FontWeight.w700),


        bodyText1: theme.textTheme.bodyText1.copyWith(
            color: AppColors.black,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        bodyText2: theme.textTheme.bodyText2.copyWith(
            color: AppColors.lightGray,
            fontSize: 11,
            fontWeight: FontWeight.normal),
      )),
    );
  }
}
