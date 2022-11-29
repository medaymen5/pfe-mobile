// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_bed_assign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditBedAssignModel _$EditBedAssignModelFromJson(Map<String, dynamic> json) =>
    EditBedAssignModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : EditBedAssignData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$EditBedAssignModelToJson(EditBedAssignModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

EditBedAssignData _$EditBedAssignDataFromJson(Map<String, dynamic> json) =>
    EditBedAssignData(
      id: json['id'] as int?,
      case_id: json['case_id'] as String?,
      ipd_patient: json['ipd_patient'] as String?,
      patient_name: json['patient_name'] as String?,
      bed: json['bed'] as String?,
      assign_date: json['assign_date'] as String?,
      discharge_date: json['discharge_date'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$EditBedAssignDataToJson(EditBedAssignData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'case_id': instance.case_id,
      'ipd_patient': instance.ipd_patient,
      'patient_name': instance.patient_name,
      'bed': instance.bed,
      'assign_date': instance.assign_date,
      'discharge_date': instance.discharge_date,
      'description': instance.description,
    };
