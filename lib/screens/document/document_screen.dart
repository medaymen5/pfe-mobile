import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/screens/document/edit_document_screen.dart';
import 'package:infyhms_flutter/screens/document/new_document_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Slidable(
                    startActionPane: ActionPane(
                      extentRatio: 0.2,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Get.to(() => EditDocumentScreen(), transition: Transition.leftToRight);
                          },
                          backgroundColor: ColorConst.orangeColor.withOpacity(0.15),
                          label: StringUtils.edit,
                          lableColor: ColorConst.orangeColor,
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      extentRatio: 0.2,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {},
                          backgroundColor: const Color(0xFFFCE5E5),
                          label: StringUtils.delete,
                          lableColor: Colors.red,
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {},
                      contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 0, right: 15, left: 15),
                      title: Text(
                        "Profile.jpg",
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.blackColor,
                          width * 0.045,
                        ),
                      ),
                      subtitle: Text(
                        "Pathology Report",
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.hintGreyColor,
                          width * 0.037,
                        ),
                      ),
                      leading: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage("assets/icon/imageIcon.png"),
                          ),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImageUtils.downloadIcon),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: GestureDetector(
              onTap: () {
                Get.to(() => NewDocumentScreen(), transition: Transition.circularReveal);
              },
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConst.blueColor,
                ),
                child: const Icon(Icons.add, color: ColorConst.whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}