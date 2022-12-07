// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionDetailsModel _$PrescriptionDetailsModelFromJson(
        Map<String, dynamic> json) =>
    PrescriptionDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : PrescriptionsDetailsData.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PrescriptionDetailsModelToJson(
        PrescriptionDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

PrescriptionsDetailsData _$PrescriptionsDetailsDataFromJson(
        Map<String, dynamic> json) =>
    PrescriptionsDetailsData(
      doctor_name: json['doctor_name'] as String?,
      specialist: json['specialist'] as String?,
      problem: json['problem'] as String?,
      test: json['test'] as String?,
      advice: json['advice'] as String?,
      medicine: (json['medicine'] as List<dynamic>?)
          ?.map((e) => Medicine.fromJson(e as Map<String, dynamic>))
          .toList(),
      download_prescription: json['download_prescription'] as String?,
    );

Map<String, dynamic> _$PrescriptionsDetailsDataToJson(
        PrescriptionsDetailsData instance) =>
    <String, dynamic>{
      'doctor_name': instance.doctor_name,
      'specialist': instance.specialist,
      'problem': instance.problem,
      'test': instance.test,
      'advice': instance.advice,
      'medicine': instance.medicine?.map((e) => e.toJson()).toList(),
      'download_prescription': instance.download_prescription,
    };

Medicine _$MedicineFromJson(Map<String, dynamic> json) => Medicine(
      name: json['name'] as String?,
      salt_composition: json['salt_composition'] as String?,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$MedicineToJson(Medicine instance) => <String, dynamic>{
      'name': instance.name,
      'salt_composition': instance.salt_composition,
      'created_at': instance.created_at,
    };
