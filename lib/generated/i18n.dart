// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'messages_all.dart';

class S {
 
  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }
  
  static Future<S> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new S();
    });
  }
  
  String get title {
    return Intl.message("HiPR Innovation", name: 'title');
  }

  String get name_hint {
    return Intl.message("First and last name", name: 'name_hint');
  }

  String get email_hint {
    return Intl.message("Email", name: 'email_hint');
  }

  String get password_hint {
    return Intl.message("Password", name: 'password_hint');
  }

  String get remember_me {
    return Intl.message("Remember me", name: 'remember_me');
  }

  String get requiredMark {
    return Intl.message("*", name: 'requiredMark');
  }

  String get requiredField {
    return Intl.message("* Required Fields", name: 'requiredField');
  }

  String get forgot_password {
    return Intl.message("Forgot Password", name: 'forgot_password');
  }

  String get login {
    return Intl.message("Login", name: 'login');
  }

  String get google_sign_in {
    return Intl.message("Sign in with Google", name: 'google_sign_in');
  }

  String get register {
    return Intl.message("New user? Register", name: 'register');
  }

  String get backButton {
    return Intl.message("Back", name: 'backButton');
  }

  String get continueButton {
    return Intl.message("Continue", name: 'continueButton');
  }

  String get registerButton {
    return Intl.message("Register", name: 'registerButton');
  }

  String get resetButton {
    return Intl.message("Reset", name: 'resetButton');
  }

  String get skipLogin {
    return Intl.message("Use without logging in", name: 'skipLogin');
  }

  String get skipMessage {
    return Intl.message("Heads up, we won't be able sync or transfer your data to a different device if you don't log in.", name: 'skipMessage');
  }

  String get resetMessage {
    return Intl.message("Sending reset email...", name: 'resetMessage');
  }

  String get logged_out {
    return Intl.message("You have been logged out, please log in again", name: 'logged_out');
  }

  String get invalid_password {
    return Intl.message("Please enter a password > 0 characters", name: 'invalid_password');
  }

  String get invalidCredentials {
    return Intl.message("Sorry, entered email and password does not match a known user", name: 'invalidCredentials');
  }

  String get welcome_dialog_title {
    return Intl.message("Welcome!", name: 'welcome_dialog_title');
  }

  String get welcome_message {
    return Intl.message("This looks like your first time opening the app!\n\nPlease help us improve your care by completing a short onboarding survey.\n\nWe will not share any answers with anyone.", name: 'welcome_message');
  }

  String get shift_protocol {
    return Intl.message("Your shift protocol", name: 'shift_protocol');
  }

  String unitString(value, unit) {
    return Intl.message("${value} ${unit}", name: 'unitString', args: [value, unit]);
  }

  String get shift_message_connector {
    return Intl.message(" every ", name: 'shift_message_connector');
  }

  String get shift_notification_start {
    return Intl.message("Notify me ", name: 'shift_notification_start');
  }

  String get shift_notification_end {
    return Intl.message(" before shift", name: 'shift_notification_end');
  }

  String get data_notification {
    return Intl.message("Caregivers with data access", name: 'data_notification');
  }

  String get add_new_caregiver {
    return Intl.message("Add", name: 'add_new_caregiver');
  }

  String get next_shift {
    return Intl.message("Until next shift", name: 'next_shift');
  }

  String get wheelchair_time {
    return Intl.message("On Wheelchair", name: 'wheelchair_time');
  }

  String next_shift_value(lastShift, timeUnit) {
    return Intl.message("${lastShift} ${timeUnit}", name: 'next_shift_value', args: [lastShift, timeUnit]);
  }

  String wheelchair_time_value(wheelchairTime, timeUnit) {
    return Intl.message("${wheelchairTime} ${timeUnit}", name: 'wheelchair_time_value', args: [wheelchairTime, timeUnit]);
  }

  String get resync {
    return Intl.message("Resyncing cushion", name: 'resync');
  }

  String get cushion_stats_title {
    return Intl.message("Your Cushion", name: 'cushion_stats_title');
  }

  String get cushion_stats_status {
    return Intl.message("Status:", name: 'cushion_stats_status');
  }

  String get cushion_stats_battery {
    return Intl.message("Battery:", name: 'cushion_stats_battery');
  }

  String get cushion_stats_uptime {
    return Intl.message("Uptime", name: 'cushion_stats_uptime');
  }

  String get cushion_connected {
    return Intl.message("Connected", name: 'cushion_connected');
  }

  String get cushion_disconnected {
    return Intl.message("Disconnected", name: 'cushion_disconnected');
  }

  String battery(percent) {
    return Intl.message("${percent}%", name: 'battery', args: [percent]);
  }

  String get unknown_value {
    return Intl.message("??", name: 'unknown_value');
  }

  String get bluetooth_disabled {
    return Intl.message("Bluetooth is currently disabled", name: 'bluetooth_disabled');
  }

  String get bluetooth_message {
    return Intl.message("Please enable bluetooth in device settings to connect to your HiPR Pressure Pad", name: 'bluetooth_message');
  }

  String get acknowledge {
    return Intl.message("Got it", name: 'acknowledge');
  }

  String get more_info {
    return Intl.message("More info", name: 'more_info');
  }

  String get dismiss {
    return Intl.message("Dismiss", name: 'dismiss');
  }

  String get add_email {
    return Intl.message("Add email...", name: 'add_email');
  }

  String invalid_answer(type) {
    return Intl.message("Please enter a valid ${type}", name: 'invalid_answer', args: [type]);
  }

  String get invalid_email {
    return Intl.message("Please enter a valid email address", name: 'invalid_email');
  }

  String get profile_settings {
    return Intl.message("Profile Settings", name: 'profile_settings');
  }

  String get device_settings {
    return Intl.message("Device Settings", name: 'device_settings');
  }

  String get survey_settings {
    return Intl.message("Survey Settings", name: 'survey_settings');
  }

  String get about_settings {
    return Intl.message("About", name: 'about_settings');
  }

  String get logout {
    return Intl.message("Log out", name: 'logout');
  }

  String get clear_pressure_data {
    return Intl.message("Clear stored pressure data", name: 'clear_pressure_data');
  }

  String get clear_success {
    return Intl.message("Data deleted successfully", name: 'clear_success');
  }

  String get clear_failure {
    return Intl.message("Error occurred, please try again", name: 'clear_failure');
  }

  String get edit_survey_data {
    return Intl.message("Edit your survey responses", name: 'edit_survey_data');
  }

  String get edit_email_data {
    return Intl.message("Change your data recipients", name: 'edit_email_data');
  }

  String get clear_survey_data {
    return Intl.message("Delete stored survey data", name: 'clear_survey_data');
  }

  String get website {
    return Intl.message("Visit Our Website", name: 'website');
  }

  String get url_error {
    return Intl.message("Error opening website", name: 'url_error');
  }

  String get or {
    return Intl.message("or", name: 'or');
  }


}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
			Locale("en", ""),

    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    return S.load(locale);
  }

  @override
  bool isSupported(Locale locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

// ignore_for_file: unnecessary_brace_in_string_interps
