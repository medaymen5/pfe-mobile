import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/doctor/doctor_payroll_controller/payroll_controller.dart';
import 'package:infyhms_flutter/screens/doctor/payroll_screen/my_pay_roll_details.dart';

class MyPayrollsScreen extends StatelessWidget {
  MyPayrollsScreen({Key? key}) : super(key: key);
  final PayrollController payrollController = Get.put(PayrollController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: ColorConst.whiteColor,
      child: Obx(() {
        return payrollController.isGetPayroll.isFalse
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  payrollController.isGetPayroll.value = false;
                  payrollController.getPayroll();
                },
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    itemCount: payrollController.payrollModel!.data!.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => MyPayRollDetailsScreen(),
                                  transition: Transition.rightToLeft,
                                  arguments: payrollController.payrollModel!.data![index].id,
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15, right: 15, top: index == 0 ? 15 : 5),
                                height: 60,
                                color: Colors.transparent,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "#${payrollController.payrollModel!.data![index].payroll_id}",
                                          style: TextStyleConst.boldTextStyle(
                                            ColorConst.blueColor,
                                            width * 0.045,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.004),
                                        RichText(
                                          text: TextSpan(
                                            text: "${payrollController.payrollModel!.data![index].status} ",
                                            style: TextStyleConst.mediumTextStyle(
                                              payrollController.payrollModel!.data![index].status == "Paid" ? Colors.green : Colors.red,
                                              width * 0.037,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    "| ${payrollController.payrollModel!.data![index].month} ${payrollController.payrollModel!.data![index].year}",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.hintGreyColor,
                                                  width * 0.037,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
      }),
    );
  }
}
