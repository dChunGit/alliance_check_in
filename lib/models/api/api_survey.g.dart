// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiSurvey _$ApiSurveyFromJson(Map<String, dynamic> json) {
  return ApiSurvey(
    json['firstname'] as String,
    json['lastname'] as String,
    json['temp'] as String,
    json['q1'] as String,
    json['q2'] as String,
    json['exposure'] as String,
    json['q3'] as String,
  );
}

Map<String, dynamic> _$ApiSurveyToJson(ApiSurvey instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'temp': instance.temp,
      'q1': instance.q1,
      'q2': instance.q2,
      'exposure': instance.exposure,
      'q3': instance.q3,
    };
