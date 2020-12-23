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
		"question1Details" : MessageLookupByLibrary.simpleMessage("The Centers for Disease Control (CDC) defines close contact as being within approximately 6 feet (2 meters) of a person with COVID-19 for a prolonged period of time (greater than 10–15 minutes). Examples include: caring for, living with a family member/friend or sharing a healthcare waiting area or room, or having direct contact with infectious secretions of a person with COVID-19 (such as being coughed or sneezed on)."),
		"question3Details" : MessageLookupByLibrary.simpleMessage("Cough, Fever, Chills, Repeated Shaking with Chills, Shortness of breath, Difficulty breathing, Muscle pains, Headache, Sore throat, New loss of taste or smell"),
		"disclaimer" : MessageLookupByLibrary.simpleMessage("By signing in to our facility, you are acknowledging that an inherent risk of exposure to COVID-19 exists in any public space where people are present, and you are voluntarily assuming all related risks and agree not to hold Alliance Technologies, its officers, or agents liable for any illness or injury."),
		"currentTemp" : MessageLookupByLibrary.simpleMessage("Current Temperature:"),
		"tempHint" : MessageLookupByLibrary.simpleMessage("--.-"),
		"selectExposureDate" : MessageLookupByLibrary.simpleMessage("Select Exposure Date"),
		"submit" : MessageLookupByLibrary.simpleMessage("SUBMIT"),
		"submitting" : MessageLookupByLibrary.simpleMessage("SUBMITTING..."),
		"moreInfo" : MessageLookupByLibrary.simpleMessage("MORE INFO"),
		"hideInfo" : MessageLookupByLibrary.simpleMessage("HIDE INFO"),
		"responseError" : MessageLookupByLibrary.simpleMessage("Response required"),
		"responseEmpty" : MessageLookupByLibrary.simpleMessage("Some responses were left empty"),
		"submit_error" : MessageLookupByLibrary.simpleMessage("Error submitting responses, please try again"),
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
