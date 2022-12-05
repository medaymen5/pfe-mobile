import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/doctor/doctor_screen_controller/doctor_controller.dart';
import 'package:infyhms_flutter/screens/doctor/doctor_screen/doctor_details_screen.dart';

class DoctorScreen extends StatelessWidget {
  DoctorScreen({Key? key}) : super(key: key);
  final DoctorScreenController doctorController = Get.put(DoctorScreenController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: ColorConst.whiteColor,
        child: Obx(() {
          return doctorController.isGetDoctor.value != true
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () async {
                    doctorController.isGetDoctor.value = false;
                    doctorController.getDoctors();
                  },
                  child: AnimationLimiter(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: doctorController.doctorsModel!.data!.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: ListTile(
                                contentPadding: EdgeInsets.only(top: index == 0 ? 5 : 0, left: 15, right: 15),
                                onTap: () {
                                  Get.to(
                                    () => DoctorDetailsScreen(),
                                    transition: Transition.rightToLeft,
                                    arguments: doctorController.doctorsModel!.data![index].id,
                                  );
                                },
                                leading: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(doctorController.doctorsModel!.data![index].doctor_image!),
                                    ),
                                  ),
                                  // child: CachedNetworkImage(
                                  //   imageUrl:
                                  //       appointmentModel!.data![index].doctor_image_url!,
                                  //   placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                  //   errorWidget: (context, url, error) => const Icon(Icons.error),
                                  // ),
                                ),
                                title: Text(
                                  doctorController.doctorsModel!.data![index].doctor_name!,
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.blackColor,
                                    width * 0.045,
                                  ),
                                ),
                                subtitle: Text(
                                  doctorController.doctorsModel!.data![index].doctor_department!,
                                  style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.036),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
        }));
  }
}
