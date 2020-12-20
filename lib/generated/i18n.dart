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
    return Intl.message("Alliance Technologies", name: 'title');
  }

  String get name_hint {
    return Intl.message("Full name", name: 'name_hint');
  }

  String get email_hint {
    return Intl.message("Email", name: 'email_hint');
  }

  String get password_hint {
    return Intl.message("Password", name: 'password_hint');
  }

  String get login {
    return Intl.message("Login", name: 'login');
  }

  String lastCheckIn(date) {
    return Intl.message("Last check in date: ${date}", name: 'lastCheckIn', args: [date]);
  }

  String checkIn(date) {
    return Intl.message("Check In For ${date}", name: 'checkIn', args: [date]);
  }

  String get firstName {
    return Intl.message("First name", name: 'firstName');
  }

  String get lastName {
    return Intl.message("Last name", name: 'lastName');
  }

  String questionHeader(number) {
    return Intl.message("Question ${number}", name: 'questionHeader', args: [number]);
  }

  String get question1 {
    return Intl.message("Have you been in close contact with someone diagnosed with COVID-19?", name: 'question1');
  }

  String get question2 {
    return Intl.message("To your knowledge, have you been exposed to the coronavirus which causes COVID-19?", name: 'question2');
  }

  String get question3 {
    return Intl.message("Are you currently experiencing any of the following symptoms or have you experienced any of them in the last 24 hours?", name: 'question3');
  }

  String get question1Details {
    return Intl.message("The Centers for Disease Control (CDC) defines close contact as being within approximately 6 feet (2 meters) of a person with COVID-19 for a prolonged period of time (greater than 10–15 minutes). Examples include: caring for, living with a family member/friend or sharing a healthcare waiting area or room, or having direct contact with infectious secretions of a person with COVID-19 (such as being coughed or sneezed on).", name: 'question1Details');
  }

  String get question3Details {
    return Intl.message("Cough, Fever, Chills, Repeated Shaking with Chills, Shortness of breath, Difficulty breathing, Muscle pains, Headache, Sore throat, New loss of taste or smell", name: 'question3Details');
  }

  String get disclaimer {
    return Intl.message("By signing in to our facility, you are acknowledging that an inherent risk of exposure to COVID-19 exists in any public space where people are present, and you are voluntarily assuming all related risks and agree not to hold Alliance Technologies, its officers, or agents liable for any illness or injury.", name: 'disclaimer');
  }

  String get currentTemp {
    return Intl.message("Current Temperature:", name: 'currentTemp');
  }

  String get tempHint {
    return Intl.message("--", name: 'tempHint');
  }

  String get selectExposureDate {
    return Intl.message("Select Exposure Date", name: 'selectExposureDate');
  }

  String get submit {
    return Intl.message("SUBMIT", name: 'submit');
  }

  String get moreInfo {
    return Intl.message("MORE INFO", name: 'moreInfo');
  }

  String get hideInfo {
    return Intl.message("HIDE INFO", name: 'hideInfo');
  }

  String get responseError {
    return Intl.message("Response required", name: 'responseError');
  }

  String get responseEmpty {
    return Intl.message("Some responses were left empty", name: 'responseEmpty');
  }

  String get yes {
    return Intl.message("YES", name: 'yes');
  }

  String get no {
    return Intl.message("NO", name: 'no');
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
