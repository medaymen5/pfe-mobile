// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_cases_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientCases _$PatientCasesFromJson(Map<String, dynamic> json) => PatientCases(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PatientCaseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PatientCasesToJson(PatientCases instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

PatientCaseData _$PatientCaseDataFromJson(Map<String, dynamic> json) =>
    PatientCaseData(
      patient_case: json['patient_case'] as String?,
    );

Map<String, dynamic> _$PatientCaseDataToJson(PatientCaseData instance) =>
    <String, dynamic>{
      'patient_case': instance.patient_case,
    };
