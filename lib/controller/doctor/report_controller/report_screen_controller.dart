import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/report_model/common_report_model/common_report_model.dart';
import 'package:infyhms_flutter/model/doctor/report_model/common_report_model/delete_common_report_model.dart';
import 'package:infyhms_flutter/model/doctor/report_model/investigation_report_model/investigation_report_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportScreenController extends GetxController {
  CommonReportModel? commonReportModel;
  DeleteCommonReportModel? deleteCommonReportModel;
  InvestigationReportModel? investigationReportModel;
  RxBool isGotReport = false.obs;
  String report = Get.arguments;
  List<RxBool> isCurrentDownloading = <RxBool>[];
  RxInt progress = 0.obs;
  int? currentIndex;
  ReceivePort receivePort = ReceivePort();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    callReportApi();
    listenDownload();
  }

  void listenDownload() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloading");
    receivePort.listen((message) {
      progress.value = message[2];
      if (progress.value == 100) {
        if (isCurrentDownloading[currentIndex ?? 0].value) {
          DisplaySnackBar.displaySnackBar("Document downloaded");
          isCurrentDownloading[currentIndex ?? 0].value = false;
          currentIndex = null;
        }
      }
    });
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @pragma('vm:entry-point')
  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
    sendPort?.send([id, status, progress]);
  }

  void downloadDocument(context, int index) async {
    if (!isCurrentDownloading.contains(true.obs)) {
      String url;
      url = investigationReportModel?.data?[index].attachment ?? "";
      currentIndex = index;
      if (Platform.isIOS) {
        launchUrl(Uri.parse(url));
      } else {
        isCurrentDownloading[index].value = true;

        try {
          Directory filePath = await Directory("storage/emulated/0/Documents/HMS").create(recursive: true);
          await FlutterDownloader.enqueue(
            url: url,
            savedDir: filePath.path,
            showNotification: true,
            openFileFromNotification: true,
            saveInPublicStorage: true,
          );
        } catch (e) {
          isCurrentDownloading[index].value = false;
          DisplaySnackBar.displaySnackBar("Document can't be downloaded");
        }
      }
    }
  }

  void callReportApi() {
    switch (report) {
      case StringUtils.birthReport:
        getBirthReport();
        break;
      case StringUtils.deathReport:
        getDeathReport();
        break;
      case StringUtils.investigationReport:
        getInvestigationReport();
        break;
      case StringUtils.operationReport:
        getOperationReport();
        break;
    }
  }

  void deleteReport(int id) {
    Get.back();
    switch (report) {
      case StringUtils.birthReport:
        deleteBirthReport(id);
        break;
      case StringUtils.deathReport:
        deleteDeathReport(id);
        break;
      case StringUtils.investigationReport:
        deleteInvestigationReport(id);
        break;
      case StringUtils.operationReport:
        deleteOperationReport(id);
        break;
    }
  }

  void getBirthReport() {
    StringUtils.client.getBirthReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        commonReportModel = value;
        if (commonReportModel!.success == true) {
          isGotReport.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return CommonReportModel();
      });
  }

  void getDeathReport() {
    StringUtils.client.getDeathReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        commonReportModel = value;
        if (commonReportModel!.success == true) {
          isGotReport.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return CommonReportModel();
      });
  }

  void getInvestigationReport() {
    StringUtils.client.getInvestigationReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        investigationReportModel = value;
        if (investigationReportModel!.success == true) {
          isGotReport.value = true;
          isCurrentDownloading = List.generate(value.data?.length ?? 1, (index) {
            return false.obs;
          });
        }
      })
      ..onError((DioError error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return InvestigationReportModel();
      });
  }

  void getOperationReport() {
    StringUtils.client.getOperationReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        commonReportModel = value;
        if (commonReportModel!.success == true) {
          isGotReport.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return CommonReportModel();
      });
  }

  void deleteBirthReport(int id) {
    isGotReport.value = false;
    StringUtils.client.deleteBirthReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          DisplaySnackBar.displaySnackBar("Report deleted");
          getBirthReport();
        }
      })
      ..onError((DioError error, stackTrace) {
        getBirthReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  void deleteDeathReport(int id) {
    isGotReport.value = false;
    StringUtils.client.deleteDeathReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          DisplaySnackBar.displaySnackBar("Report deleted");
          getDeathReport();
        }
      })
      ..onError((DioError error, stackTrace) {
        getDeathReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  void deleteOperationReport(int id) {
    isGotReport.value = false;
    StringUtils.client.deleteOperationReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          DisplaySnackBar.displaySnackBar("Report deleted");
          getOperationReport();
        }
      })
      ..onError((DioError error, stackTrace) {
        getOperationReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  void deleteInvestigationReport(int id) {
    isGotReport.value = false;
    StringUtils.client.deleteInvestigationReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          DisplaySnackBar.displaySnackBar("Report deleted");
          getInvestigationReport();
        }
      })
      ..onError((DioError error, stackTrace) {
        getInvestigationReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    receivePort.close();
    IsolateNameServer.removePortNameMapping('downloading');
  }
}
