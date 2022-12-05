import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/bills_controller/bills_controller.dart';
import 'package:infyhms_flutter/screens/patient/bills/bills_detail_screen.dart';

class BillScreen extends StatelessWidget {
  BillScreen({Key? key}) : super(key: key);
  final BillsController billsController = Get.put(BillsController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Obx(() => billsController.isGetBills == true.obs
        ? billsController.billsModel!.data!.isEmpty
            ? Center(
                child: Text(
                  "No bills found",
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.blackColor,
                    width * 0.04,
                  ),
                ),
              )
            : Container(
                color: Colors.white,
                child: RefreshIndicator(
                  onRefresh: () async {
                    billsController.isGetBills.value = false;
                    billsController.getBill();
                  },
                  child: AnimationLimiter(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: billsController.billsModel!.data!.length,
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
                                    arguments: billsController.billsModel!.data![index].id!,
                                    () => BillDetailScreen(),
                                    transition: Transition.rightToLeft,
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
                                            billsController.billsModel!.data![index].bill_id!,
                                            style: TextStyleConst.boldTextStyle(
                                              ColorConst.blueColor,
                                              width * 0.045,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.002),
                                          Text(
                                            billsController.billsModel!.data![index].bill_date!,
                                            style: TextStyleConst.mediumTextStyle(
                                              ColorConst.hintGreyColor,
                                              width * 0.037,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: ColorConst.bgGreyColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                billsController.billsModel!.data![index].currency!,
                                                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, width * 0.04),
                                              ),
                                              Text(
                                                " ${billsController.billsModel!.data![index].amount!}",
                                                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, width * 0.04),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
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
                ),
              )
        : const Center(child: CircularProgressIndicator()));
  }
}
