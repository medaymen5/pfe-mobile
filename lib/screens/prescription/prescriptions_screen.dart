import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/screens/prescription/prescription_detail_screen.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 15 : 0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Get.to(() => const PrescriptionsDetailScreen(), transition: Transition.rightToLeft);
                },
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    "Jenil Shah",
                    style: TextStyleConst.mediumTextStyle(
                      ColorConst.blackColor,
                      width * 0.045,
                    ),
                  ),
                ),
                subtitle: Text(
                  "12:00 AM - 9th Jun, 2022",
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.hintGreyColor,
                    width * 0.037,
                  ),
                ),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}