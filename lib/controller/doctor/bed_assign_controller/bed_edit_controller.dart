import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/bed_update_model.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/beds_model.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/edit_bed_assign_model.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/patient_cases_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class EditBedController extends GetxController {
  String? selectedDate = "";
  String? selectedBedAssignDate;
  String? selectedDischargeDate;

  final TextEditingController myCaseController = TextEditingController();
  final TextEditingController ipdPatientController = TextEditingController();
  final TextEditingController selectedBedAssignController = TextEditingController();
  final TextEditingController selectedDischargeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  PatientCases? patientCases;
  EditBedAssignModel? editBedAssignModel;

  BedsModel? bedsModel;
  RxBool isEditBedApiCalled = false.obs;

  Map<String, dynamic> bedAssignData = Get.arguments;

  DateTime? oldAssignDate;
  DateTime? oldDischargeDate;

  String? myCases;
  String? ipdPatient;
  String? bed;

  String? myCasesId;
  String? ipdPatientId;
  String? bedId;

  String? assignId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEditBedDetails();
    bedId = bedAssignData["bedId"];
    bed = bedAssignData["bed"];
    assignId = bedAssignData["assignId"];
  }

  Future<String?> selectDate(BuildContext context, DateTime? oldDate, bool isAssign) async {
    DateTime? picked = await DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      currentTime: oldDate ?? DateTime.now(),
    );
    if (picked != null) {
      if (isAssign) {
        oldAssignDate = picked;
      } else {
        oldDischargeDate = picked;
      }
      selectedDate =
          "${picked.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day} ${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:${picked.second.toString().padLeft(2, '0')}";
      return selectedDate ?? "";
    } else {
      return null;
    }
  }

  void getEditBedDetails() {
    StringUtils.client.getBedEditAssignDetails(PreferenceUtils.getStringValue("token"), int.parse(bedAssignData["assignId"]))
      ..then((value) {
        editBedAssignModel = value;
        myCaseController.text = "${editBedAssignModel!.data!.case_id} ${editBedAssignModel!.data!.patient_name}";
        ipdPatientController.text = "${editBedAssignModel!.data!.ipd_patient}";
        selectedBedAssignController.text = editBedAssignModel!.data!.assign_date!;
        selectedBedAssignDate = editBedAssignModel!.data!.assign_date!;
        selectedDischargeController.text = editBedAssignModel!.data!.discharge_date! == "N/A" ? "" : editBedAssignModel!.data!.discharge_date!;
        selectedDischargeDate = editBedAssignModel!.data!.discharge_date! == "N/A" ? null : editBedAssignModel!.data!.discharge_date!;
        getBeds();
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return EditBedAssignModel();
      });
  }

  void getBeds() {
    StringUtils.client.getBedsForEdit(PreferenceUtils.getStringValue("token"), "$bedId")
      ..then((value) {
        bedsModel = value;
        isEditBedApiCalled.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return BedsModel();
      });
  }

  void selectAssignDate(BuildContext context) async {
    selectedBedAssignDate = (await selectDate(context, oldAssignDate, true)) ?? selectedBedAssignDate;
    selectedBedAssignController.text = selectedBedAssignDate ?? "";
  }

  void selectDischargeDate(BuildContext context) async {
    selectedDischargeDate = (await selectDate(context, oldDischargeDate, false)) ?? selectedDischargeDate;
    selectedDischargeController.text = selectedDischargeDate ?? "";
  }

  void saveData() {
    if (bedId == null) {
      DisplaySnackBar.displaySnackBar("Please select bed");
    } else if (selectedBedAssignDate == null) {
      DisplaySnackBar.displaySnackBar("Please select assign date");
    } else {
      CommonLoader.showLoader();
      StringUtils.client.updateBedAssign(
        PreferenceUtils.getStringValue("token"),
        "${bedAssignData["assignId"]}",
        "$bedId",
        "${editBedAssignModel!.data!.ipd_patient}",
        "${editBedAssignModel!.data!.case_id}",
        "$selectedBedAssignDate",
        selectedDischargeDate,
      )
        ..then((value) {
          Get.back();
          Get.back(result: "Call API");
          DisplaySnackBar.displaySnackBar("Bed details updated successfully");
        })
        ..onError((DioError error, stackTrace) {
          Get.back();
          CheckSocketException.checkSocketException(error);
          return BedUpdatedDetailsModel();
        });
    }
  }
}
