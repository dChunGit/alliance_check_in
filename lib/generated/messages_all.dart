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
		"question1" : MessageLookupByLibrary.simpleMessage("Have you been in close contact with someone diagnosed with COVID-19?"),
		"question2" : MessageLookupByLibrary.simpleMessage("To your knowledge, have you been exposed to the coronavirus which causes COVID-19?"),
		"question3" : MessageLookupByLibrary.simpleMessage("Are you currently experiencing any of the following symptoms or have you experienced any of them in the last 24 hours:"),
		"question1Details" : MessageLookupByLibrary.simpleMessage("The Centers for DiseaseControl (CDC) defines close contact as being within approximately 6 feet(2 meters) of a person with COVID-19 for a prolonged period of time (greater than 10 – 15 minutes). Examples include: caring for, living with a family member/friend or sharing a healthcare waiting area or room, or having direct contact with infectious secretions of a person with COVID-19 (such as being coughed or sneezed on)."),
		"question3Details" : MessageLookupByLibrary.simpleMessage("Cough, Fever, Chills, Repeated Shaking with Chills, Shortness of breath, Difficulty breathing, Muscle pains, Headache, Sore throat, New loss of taste or smell?"),

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
