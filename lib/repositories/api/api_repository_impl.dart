import 'dart:convert';
import 'dart:io';

import 'package:alliance_tech_check_in/config/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';

import 'api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {

  final _client = new RetryClient(new http.Client(), retries: 5);

  Future<bool> postRequest(FirebaseUser user, Map<String, dynamic> data, String endpoint) async {
    if (user == null) {
      return false;
    }

    var token = await user.getIdToken();

    print(jsonEncode(data));

    final http.Response response = await _client.post(
        apiUrl + endpoint,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${token.token}",
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: jsonEncode(data)
    );

    print("${response.statusCode} : ${response.body}");

    switch (response.statusCode) {
      case 201: return true;
      default: return false;
    }
  }

  Future<String> getRequest(FirebaseUser user) async {
    if (user == null) {
      return null;
    }

    var token = await user.getIdToken();

    final http.Response response = await _client.get(
      apiUrl,
      headers: { HttpHeaders.authorizationHeader: "Bearer ${token.token}" },
    );

    switch (response.statusCode) {
      case 201: return response.body;
      default: return null;
    }
  }
}