import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_alert_box.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/doctor/doctor_prescription_controller/doctor_prescription_controller.dart';
import 'package:infyhms_flutter/screens/doctor/doctor_prescription/doctor_prescription_detail_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DoctorPrescriptionScreen extends StatelessWidget {
  DoctorPrescriptionScreen({Key? key}) : super(key: key);
  final DoctorPrescriptionController doctorPrescriptionController = Get.put(DoctorPrescriptionController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        color: ColorConst.whiteColor,
        child: Obx(() {
          return doctorPrescriptionController.isGetPrescription.value != true
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: doctorPrescriptionController.doctorPrescriptionModel!.data!.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              ContentOfDialog contentOfDialog = ContentOfDialog(
                                height: height,
                                width: width,
                                image: ImageUtils.deleteIcon,
                                title: "Delete",
                                description: "Are you sure want to delete\nthis prescription?",
                                leftText: StringUtils.delete,
                                rightText: StringUtils.cancel,
                                leftTapEvent: () {
                                  Get.back();
                                  doctorPrescriptionController
                                      .deletePrescription(doctorPrescriptionController.doctorPrescriptionModel!.data![index].id!);
                                },
                                rightTapEvent: () {
                                  Get.back();
                                },
                              );
                              CommonAlertDialog.commonAlertDialog(context, contentOfDialog);
                            },
                            backgroundColor: const Color(0xFFFCE5E5),
                            foregroundColor: ColorConst.redColor,
                            label: StringUtils.delete,
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(top: index == 0 ? 5 : 0, left: 15, right: 15),
                        onTap: () {
                          Get.to(
                            () => DoctorPrescriptionDetailScreen(),
                            transition: Transition.rightToLeft,
                            arguments: doctorPrescriptionController.doctorPrescriptionModel!.data![index].id,
                          );
                        },
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(doctorPrescriptionController.doctorPrescriptionModel!.data![index].patient_image!),
                            ),
                          ),
                        ),
                        title: Text(
                          doctorPrescriptionController.doctorPrescriptionModel!.data![index].patient_name!,
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.045,
                          ),
                        ),
                        subtitle: Text(
                          doctorPrescriptionController.doctorPrescriptionModel!.data![index].created_date!,
                          style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.036),
                        ),
                      ),
                    );
                  },
                );
        }));
  }
}
