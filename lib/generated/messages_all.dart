// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

final _$en = $en();

class $en extends MessageLookupByLibrary {
  get localeName => 'en';
  
  final messages = {
		"title" : MessageLookupByLibrary.simpleMessage("Alliance Technologies"),
		"name_hint" : MessageLookupByLibrary.simpleMessage("Username"),
		"email_hint" : MessageLookupByLibrary.simpleMessage("Email"),
		"password_hint" : MessageLookupByLibrary.simpleMessage("Password"),
		"new_password_hint" : MessageLookupByLibrary.simpleMessage("New password"),
		"confirm_password_hint" : MessageLookupByLibrary.simpleMessage("Confirm new password"),
		"confirm_code_hint" : MessageLookupByLibrary.simpleMessage("Confirmation code"),
		"login" : MessageLookupByLibrary.simpleMessage("Login"),
		"forgotPassword" : MessageLookupByLibrary.simpleMessage("Forgot password"),
		"resetPassword" : MessageLookupByLibrary.simpleMessage("Reset password"),
		"changePassword" : MessageLookupByLibrary.simpleMessage("Change password"),
		"next" : MessageLookupByLibrary.simpleMessage("Next"),
		"back" : MessageLookupByLibrary.simpleMessage("Back"),
		"username_error" : MessageLookupByLibrary.simpleMessage("Username must not be empty"),
		"password_error" : MessageLookupByLibrary.simpleMessage("Password must not be empty"),
		"confirmation_error" : MessageLookupByLibrary.simpleMessage("Confirmation code must not be empty"),
		"password_change_error" : MessageLookupByLibrary.simpleMessage("Error changing password, please try again"),
		"password_match_error" : MessageLookupByLibrary.simpleMessage("Passwords must match"),
		"password_constraints_error" : MessageLookupByLibrary.simpleMessage("Password must be at least 8 characters long, include lowercase and uppercase letters, and at least one number"),
		"login_cred_error" : MessageLookupByLibrary.simpleMessage("Incorrect username or password, please try again"),
		"generic_login_error" : MessageLookupByLibrary.simpleMessage("Error logging in, please try again"),
		"first_time_dialog_title" : MessageLookupByLibrary.simpleMessage("Welcome!"),
		"first_time_dialog_message" : MessageLookupByLibrary.simpleMessage("Since it's your first time logging in, you will need to set your own password"),
		"lastCheckIn" : (date) => "Last checked in: ${date}",
		"checkIn" : (date) => "Check In For ${date}",
		"firstName" : MessageLookupByLibrary.simpleMessage("First name"),
		"lastName" : MessageLookupByLibrary.simpleMessage("Last name"),
		"questionHeader" : (number) => "Question ${number}",
		"question1" : MessageLookupByLibrary.simpleMessage("Have you been in close contact with someone diagnosed with COVID-19?"),
		"question2" : MessageLookupByLibrary.simpleMessage("To your knowledge, have you been exposed to the coronavirus which causes COVID-19?"),
		"question3" : MessageLookupByLibrary.simpleMessage("Are you currently experiencing any of the following symptoms or have you experienced any of them in the last 24 hours?"),
		"question1Details" : MessageLookupByLibrary.simpleMessage("Close contact is defined by CDC as someone who was within 6 feet of an infected person for a cumulative total of 15 minutes or more over a 24-hour period starting from 2 days before illness onset (or, for asymptomatic patients, 2 days prior to test specimen collection) until the time the patient is isolated."),
		"question3Details" : MessageLookupByLibrary.simpleMessage("Cough, Fever, Chills, Shortness of breath, Difficulty breathing, Fatigue, Muscle pains, Headache, Sore throat, New loss of taste or smell"),
		"disclaimer" : MessageLookupByLibrary.simpleMessage("By signing in to our facility, you are acknowledging that an inherent risk of exposure to COVID-19 exists in any public space where people are present, and you are voluntarily assuming all related risks and agree not to hold Alliance Technologies, its officers, or agents liable for any illness or injury."),
		"currentTemp" : MessageLookupByLibrary.simpleMessage("Current Temperature:"),
		"tempHint" : MessageLookupByLibrary.simpleMessage("--.-"),
		"selectExposureDate" : MessageLookupByLibrary.simpleMessage("Select Exposure Date"),
		"submit" : MessageLookupByLibrary.simpleMessage("SUBMIT"),
		"submitting" : MessageLookupByLibrary.simpleMessage("SUBMITTING..."),
		"moreInfo" : MessageLookupByLibrary.simpleMessage("MORE INFO"),
		"hideInfo" : MessageLookupByLibrary.simpleMessage("HIDE INFO"),
		"responseError" : MessageLookupByLibrary.simpleMessage("Response invalid"),
		"responseEmpty" : MessageLookupByLibrary.simpleMessage("Some responses were left empty or were invalid"),
		"submit_error" : MessageLookupByLibrary.simpleMessage("Error submitting responses, please try again"),
		"view_disclaimer" : MessageLookupByLibrary.simpleMessage("Please read the disclaimer before submitting!"),
		"submit_complete_title" : MessageLookupByLibrary.simpleMessage("Success!"),
		"submit_complete_message" : MessageLookupByLibrary.simpleMessage("Check in completed!"),
		"yes" : MessageLookupByLibrary.simpleMessage("YES"),
		"no" : MessageLookupByLibrary.simpleMessage("NO"),
		"ok" : MessageLookupByLibrary.simpleMessage("OK"),

  };
}



typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
	"en": () => Future.value(null),

};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case "en":
        return _$en;

    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName,
          (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());

  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);

  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}

// ignore_for_file: unnecessary_brace_in_string_interps
