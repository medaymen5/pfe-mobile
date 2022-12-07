import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/report_model/doctor_case_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DoctorCaseDetailsController extends GetxController {
  DoctorCaseDetailsModel? doctorCaseDetailsModel;
  RxBool isGotDetails = false.obs;
  String caseId = Get.arguments;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDoctorCaseDetails();
  }

  void getDoctorCaseDetails() {
    StringUtils.client.getDoctorCaseDetails(PreferenceUtils.getStringValue("token"), caseId)
      ..then((value) {
        doctorCaseDetailsModel = value;
        if (doctorCaseDetailsModel!.success == true) {
          isGotDetails.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        isGotDetails.value = true;
        CheckSocketException.checkSocketException(error);
        return DoctorCaseDetailsModel();
      });
  }
}
