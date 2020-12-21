import 'package:alliance_tech_check_in/models/api/api_survey.dart';

abstract class ApiService {
  Future<void> init();
  Future<bool> sendSurveyData(ApiSurvey surveyData);
}