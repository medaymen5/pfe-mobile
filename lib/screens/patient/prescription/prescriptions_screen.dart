import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/prescription_controller/prescription_controller.dart';
import 'package:infyhms_flutter/screens/patient/prescription/prescription_detail_screen.dart';

class PrescriptionsScreen extends StatelessWidget {
  PrescriptionsScreen({Key? key}) : super(key: key);
  final PrescriptionController prescriptionController = Get.put(PrescriptionController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => prescriptionController.isGetPrescription.value == true
          ? prescriptionController.prescriptionsModel!.data!.isEmpty
              ? Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No prescription found",
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.blackColor,
                        width * 0.04,
                      ),
                    ),
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      prescriptionController.isGetPrescription.value = false;
                      prescriptionController.getPrescription();
                    },
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: prescriptionController.prescriptionsModel!.data!.length,
                        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1000),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 10, left: 15, right: 15),
                                  onTap: () {
                                    Get.to(
                                      () => PrescriptionsDetailScreen(),
                                      transition: Transition.rightToLeft,
                                      arguments: prescriptionController.prescriptionsModel!.data![index].id!,
                                    );
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      prescriptionController.prescriptionsModel!.data![index].doctor_name!,
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.blackColor,
                                        width * 0.045,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${prescriptionController.prescriptionsModel!.data![index].created_time!} - ${prescriptionController.prescriptionsModel!.data![index].created_date!}",
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.hintGreyColor,
                                      width * 0.037,
                                    ),
                                  ),
                                  leading: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(prescriptionController.prescriptionsModel!.data![index].doctor_image!),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
