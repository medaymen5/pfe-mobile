import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/bills_model/bill_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class BillsController extends GetxController {
  BillsModel? billsModel;
  RxBool isGetBills = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBill();
  }

  void getBill() {
    StringUtils.client.getBills(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        billsModel = value;
        isGetBills.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return BillsModel();
      });
  }
}
