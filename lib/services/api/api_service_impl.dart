import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alliance_tech_check_in/config/constants.dart';
import 'package:alliance_tech_check_in/config/secrets.dart';
import 'package:alliance_tech_check_in/locator.dart';
import 'package:alliance_tech_check_in/models/api/api_survey.dart';
import 'package:alliance_tech_check_in/services/api/auth_service.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';

import 'api_service.dart';

class ApiServiceImpl implements ApiService {
  final AuthService _authService;

  final _client = new RetryClient(new http.Client(), retries: 1);
  AwsSigV4Client _awsClient;

  ApiServiceImpl()
      : _authService = sl();

  Future<void> init() async {
    // final credentials = await _authService.getCredentials();
    print("Got credentials");

    // _awsClient = AwsSigV4Client(
    //     credentials.accessKeyId,
    //     credentials.secretAccessKey,
    //     url,
    //     region: "us-east-1",
    //     sessionToken: credentials.sessionToken
    // );
  }

  Future<bool> sendSurveyData(ApiSurvey surveyData) async {
    print(surveyData.toJson());
    // var signedRequest = new SigV4Request(
    //     _awsClient,
    //     method: "POST",
    //     path: checkInEndpoint,
    //     body: jsonEncode(surveyData.toJson())
    // );

    return postRequest(surveyData.toJson(), checkInEndpoint);
  }

  Future<bool> postRequest(Map<String, dynamic> data, String endpoint) async {
    print(jsonEncode(data));

    try {
      final token = await _authService.getToken();

      final http.Response response = await _client.post(
          url + endpoint,
          headers: {
            HttpHeaders.authorizationHeader: "$token",
            HttpHeaders.contentTypeHeader: "application/json",
            "x-api-key": apiKey
          },
          body: jsonEncode(data)
      ).timeout(const Duration(seconds: 5), onTimeout: () {
        return http.Response("", 503);
      });

      print("${response.statusCode} : ${response.body}");

      switch (response.statusCode) {
        case 200: return true;
        default: return false;
      }
    }
    on Exception catch (_) {
      return false;
    }
  }
}