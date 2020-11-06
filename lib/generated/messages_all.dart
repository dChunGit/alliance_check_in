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
		"title" : MessageLookupByLibrary.simpleMessage("HiPR Innovation"),
		"name_hint" : MessageLookupByLibrary.simpleMessage("First and last name"),
		"email_hint" : MessageLookupByLibrary.simpleMessage("Email"),
		"password_hint" : MessageLookupByLibrary.simpleMessage("Password"),
		"remember_me" : MessageLookupByLibrary.simpleMessage("Remember me"),
		"requiredMark" : MessageLookupByLibrary.simpleMessage("*"),
		"requiredField" : MessageLookupByLibrary.simpleMessage("* Required Fields"),
		"forgot_password" : MessageLookupByLibrary.simpleMessage("Forgot Password"),
		"login" : MessageLookupByLibrary.simpleMessage("Login"),
		"google_sign_in" : MessageLookupByLibrary.simpleMessage("Sign in with Google"),
		"register" : MessageLookupByLibrary.simpleMessage("New user? Register"),
		"backButton" : MessageLookupByLibrary.simpleMessage("Back"),
		"continueButton" : MessageLookupByLibrary.simpleMessage("Continue"),
		"registerButton" : MessageLookupByLibrary.simpleMessage("Register"),
		"resetButton" : MessageLookupByLibrary.simpleMessage("Reset"),
		"skipLogin" : MessageLookupByLibrary.simpleMessage("Use without logging in"),
		"skipMessage" : MessageLookupByLibrary.simpleMessage("Heads up, we won't be able sync or transfer your data to a different device if you don't log in."),
		"resetMessage" : MessageLookupByLibrary.simpleMessage("Sending reset email..."),
		"logged_out" : MessageLookupByLibrary.simpleMessage("You have been logged out, please log in again"),
		"invalid_password" : MessageLookupByLibrary.simpleMessage("Please enter a password > 0 characters"),
		"invalidCredentials" : MessageLookupByLibrary.simpleMessage("Sorry, entered email and password does not match a known user"),
		"welcome_dialog_title" : MessageLookupByLibrary.simpleMessage("Welcome!"),
		"welcome_message" : MessageLookupByLibrary.simpleMessage("This looks like your first time opening the app!\n\nPlease help us improve your care by completing a short onboarding survey.\n\nWe will not share any answers with anyone."),
		"shift_protocol" : MessageLookupByLibrary.simpleMessage("Your shift protocol"),
		"unitString" : (value, unit) => "${value} ${unit}",
		"shift_message_connector" : MessageLookupByLibrary.simpleMessage(" every "),
		"shift_notification_start" : MessageLookupByLibrary.simpleMessage("Notify me "),
		"shift_notification_end" : MessageLookupByLibrary.simpleMessage(" before shift"),
		"data_notification" : MessageLookupByLibrary.simpleMessage("Caregivers with data access"),
		"add_new_caregiver" : MessageLookupByLibrary.simpleMessage("Add"),
		"next_shift" : MessageLookupByLibrary.simpleMessage("Until next shift"),
		"wheelchair_time" : MessageLookupByLibrary.simpleMessage("On Wheelchair"),
		"next_shift_value" : (lastShift, timeUnit) => "${lastShift} ${timeUnit}",
		"wheelchair_time_value" : (wheelchairTime, timeUnit) => "${wheelchairTime} ${timeUnit}",
		"resync" : MessageLookupByLibrary.simpleMessage("Resyncing cushion"),
		"cushion_stats_title" : MessageLookupByLibrary.simpleMessage("Your Cushion"),
		"cushion_stats_status" : MessageLookupByLibrary.simpleMessage("Status:"),
		"cushion_stats_battery" : MessageLookupByLibrary.simpleMessage("Battery:"),
		"cushion_stats_uptime" : MessageLookupByLibrary.simpleMessage("Uptime"),
		"cushion_connected" : MessageLookupByLibrary.simpleMessage("Connected"),
		"cushion_disconnected" : MessageLookupByLibrary.simpleMessage("Disconnected"),
		"battery" : (percent) => "${percent}%",
		"unknown_value" : MessageLookupByLibrary.simpleMessage("??"),
		"bluetooth_disabled" : MessageLookupByLibrary.simpleMessage("Bluetooth is currently disabled"),
		"bluetooth_message" : MessageLookupByLibrary.simpleMessage("Please enable bluetooth in device settings to connect to your HiPR Pressure Pad"),
		"acknowledge" : MessageLookupByLibrary.simpleMessage("Got it"),
		"more_info" : MessageLookupByLibrary.simpleMessage("More info"),
		"dismiss" : MessageLookupByLibrary.simpleMessage("Dismiss"),
		"add_email" : MessageLookupByLibrary.simpleMessage("Add email..."),
		"invalid_answer" : (type) => "Please enter a valid ${type}",
		"invalid_email" : MessageLookupByLibrary.simpleMessage("Please enter a valid email address"),
		"profile_settings" : MessageLookupByLibrary.simpleMessage("Profile Settings"),
		"device_settings" : MessageLookupByLibrary.simpleMessage("Device Settings"),
		"survey_settings" : MessageLookupByLibrary.simpleMessage("Survey Settings"),
		"about_settings" : MessageLookupByLibrary.simpleMessage("About"),
		"logout" : MessageLookupByLibrary.simpleMessage("Log out"),
		"clear_pressure_data" : MessageLookupByLibrary.simpleMessage("Clear stored pressure data"),
		"clear_success" : MessageLookupByLibrary.simpleMessage("Data deleted successfully"),
		"clear_failure" : MessageLookupByLibrary.simpleMessage("Error occurred, please try again"),
		"edit_survey_data" : MessageLookupByLibrary.simpleMessage("Edit your survey responses"),
		"edit_email_data" : MessageLookupByLibrary.simpleMessage("Change your data recipients"),
		"clear_survey_data" : MessageLookupByLibrary.simpleMessage("Delete stored survey data"),
		"website" : MessageLookupByLibrary.simpleMessage("Visit Our Website"),
		"url_error" : MessageLookupByLibrary.simpleMessage("Error opening website"),
		"or" : MessageLookupByLibrary.simpleMessage("or"),

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
