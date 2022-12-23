import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/screens/patient/auth/login_screen.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';

class CheckSocketException {
  static void checkSocketException(DioError error, [int? sec, String? showError]) {
    if (error.error is SocketException) {
      Get.rawSnackbar(
        backgroundColor: const Color(0xff2d2d2d),
        messageText: Text(
          "Please check internet connection",
          style: TextStyleConst.mediumTextStyle(Colors.white, 15),
        ),
        borderRadius: 5,
        duration: Duration(seconds: sec ?? 5),
        margin: const EdgeInsets.all(10),
        dismissDirection: DismissDirection.horizontal,
      );
    } else if (error.response.toString().contains("Token Expired")) {
      PreferenceUtils.setStringValue("token", "");
      Get.offAll(() => LoginScreen());
      DisplaySnackBar.displaySnackBar("Session expired");
    } else {
      Get.rawSnackbar(
        backgroundColor: const Color(0xff2d2d2d),
        messageText: Text(
          showError ?? error.response?.data["message"] ?? error.message,
          style: TextStyleConst.mediumTextStyle(Colors.white, 15),
        ),
        borderRadius: 5,
        duration: Duration(seconds: sec ?? 5),
        margin: const EdgeInsets.all(10),
        dismissDirection: DismissDirection.horizontal,
      );
    }
  }
}
