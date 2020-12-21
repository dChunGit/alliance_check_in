import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorageService extends CognitoStorage {
  final SharedPreferences _sharedPrefs;

  AuthStorageService(this._sharedPrefs);

  @override
  Future<void> clear() async {
    print("clearing all");
    await _sharedPrefs.clear();
  }

  @override
  Future<String> getItem(String key) async {
    print("getting item $key");
    String item;
    try {
      item = json.decode(_sharedPrefs.getString(key));
    } catch (e) {
      print("could not decode");
      return null;
    }
    return item;
  }

  @override
  Future<String> removeItem(String key) async {
    print("removing item");
    final item = getItem(key);
    if (item != null) {
      await _sharedPrefs.remove(key);
      return item;
    }
    return null;
  }

  @override
  Future<String> setItem(String key, value) async {
    print("setting item $key");
    await _sharedPrefs.setString(key, json.encode(value));
    return getItem(key);
  }
}