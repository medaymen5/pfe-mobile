import 'package:json_annotation/json_annotation.dart';

part 'edit_bed_assign_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EditBedAssignModel {
  bool? success;
  EditBedAssignData? data;
  String? message;

  EditBedAssignModel({
    this.success,
    this.data,
    this.message,
  });

  factory EditBedAssignModel.fromJson(Map<String, dynamic> json) => _$EditBedAssignModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditBedAssignModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EditBedAssignData {
  int? id;
  String? case_id;
  String? ipd_patient;
  String? patient_name;
  String? bed;
  String? assign_date;
  String? discharge_date;
  String? description;

  EditBedAssignData({
    this.id,
    this.case_id,
    this.ipd_patient,
    this.patient_name,
    this.bed,
    this.assign_date,
    this.discharge_date,
    this.description,
  });
  factory EditBedAssignData.fromJson(Map<String, dynamic> json) => _$EditBedAssignDataFromJson(json);

  Map<String, dynamic> toJson() => _$EditBedAssignDataToJson(this);
}
