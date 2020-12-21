import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_survey.g.dart';

@JsonSerializable(nullable: true)
class ApiSurvey {
  final String firstname;
  final String lastname;
  final String temp;
  final String q1;
  final String q2;
  final String exposure;
  final String q3;

  ApiSurvey(this.firstname, this.lastname, this.temp, this.q1, this.q2, this.exposure, this.q3);

  factory ApiSurvey.fromValues(String firstname, String lastname, String temp, bool q1, bool q2, DateTime exposure, bool q3) {
    var exposureDate = (exposure == null) ? "N/A" : DateFormat.yMd().format(exposure);
    return ApiSurvey(
      firstname,
      lastname,
      temp,
      (q1) ? "Y":"N",
      (q2) ? "Y":"N",
      exposureDate,
      (q3) ? "Y":"N",
    );
  }

  factory ApiSurvey.fromJson(Map<String, dynamic> json) => _$ApiSurveyFromJson(json);
  Map<String, dynamic> toJson() => _$ApiSurveyToJson(this);
}