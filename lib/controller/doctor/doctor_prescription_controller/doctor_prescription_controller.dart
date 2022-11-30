import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_prescription_model/doctor_prescription_model.dart';
import 'package:infyhms_flutter/model/doctor/report_model/common_report_model/delete_common_report_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DoctorPrescriptionController extends GetxController {
  RxBool isGetPrescription = false.obs;
  DoctorPrescriptionModel? doctorPrescriptionModel;
  DeleteCommonReportModel? deleteCommonReportModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDoctorPrescription();
  }

  void getDoctorPrescription() {
    StringUtils.client.getDoctorsPrescription(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorPrescriptionModel = value;
        isGetPrescription.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorPrescriptionModel();
      });
  }

  void deletePrescription(int id) {
    isGetPrescription.value = false;
    StringUtils.client.deletePrescriptionReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          getDoctorPrescription();
        }
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }
}
