// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsModel _$DocumentsModelFromJson(Map<String, dynamic> json) => DocumentsModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)?.map((e) => DocumentData.fromJson(e as Map<String, dynamic>)).toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DocumentsModelToJson(DocumentsModel instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

DocumentData _$DocumentDataFromJson(Map<String, dynamic> json) => DocumentData(
      id: json['id'] as int?,
      title: json['title'] as String?,
      document_type_id: json['document_type_id'] as int?,
      patient_id: json['patient_id'] as int?,
      uploaded_by: json['uploaded_by'] as int?,
      notes: json['notes'] as String?,
      is_default: json['is_default'],
      document_url: json['document_url'] as String?,
    );

Map<String, dynamic> _$DocumentDataToJson(DocumentData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'document_type_id': instance.document_type_id,
      'patient_id': instance.patient_id,
      'uploaded_by': instance.uploaded_by,
      'notes': instance.notes,
      'is_default': instance.is_default,
      'document_url': instance.document_url,
    };
