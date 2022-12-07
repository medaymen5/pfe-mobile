import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/auth_controller/sign_up_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: ColorConst.bgGreyColor,
          body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  /// top logo
                  Container(
                    alignment: Alignment.center,
                    height: height / 3.2,
                    color: ColorConst.bgGreyColor,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageUtils.splashLogo),
                        ),
                      ),
                    ),
                  ),

                  /// bottom container
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        Container(
                          height: height / 3.2,
                          width: width,
                          color: ColorConst.bgGreyColor,
                        ),
                        Container(
                          height: height / 1.53,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorConst.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: ColorConst.greyShadowColor,
                                blurRadius: 5,
                                spreadRadius: 3,
                                offset: const Offset(0, -5),
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(60),
                              topLeft: Radius.circular(60),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: height * 0.06, left: 20, right: 20),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// SignIn
                                  Center(
                                    child: Text(
                                      StringUtils.patientRegistration,
                                      style: TextStyleConst.boldTextStyle(
                                        Colors.black,
                                        width * 0.06,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),

                                  /// Email TextField
                                  CommonTextField(
                                    controller: signUpController.firstController,
                                    keyBoardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      return null;
                                    },
                                    hintText: "Enter First Name",
                                  ),
                                  SizedBox(height: height * 0.02),
                                  CommonTextField(
                                    controller: signUpController.lastController,
                                    keyBoardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      return null;
                                    },
                                    hintText: "Enter Last Name",
                                  ),
                                  SizedBox(height: height * 0.02),
                                  CommonTextField(
                                    controller: signUpController.emailController,
                                    keyBoardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      return null;
                                    },
                                    hintText: "Enter Email Address",
                                  ),
                                  SizedBox(height: height * 0.02),
                                  CommonTextField(
                                    controller: signUpController.passwordController,
                                    keyBoardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      return null;
                                    },
                                    hintText: "Enter Password",
                                  ),
                                  SizedBox(height: height * 0.02),
                                  CommonTextField(
                                    controller: signUpController.confirmPasswordController,
                                    keyBoardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      return null;
                                    },
                                    hintText: "Re-enter Password",
                                  ),
                                  SizedBox(height: height * 0.02),

                                  Text(
                                    "Select Gender:",
                                    style: TextStyleConst.boldTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.04,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.015),

                                  /// Radio button
                                  SizedBox(
                                    height: 30,
                                    width: 195,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              signUpController.currentIndex.value = 0;
                                            },
                                            child: Obx(
                                              () => signUpController.currentIndex.value == 0
                                                  ? Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: ColorConst.blueColor,
                                                      ),
                                                      child: Center(
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: ColorConst.whiteColor,
                                                          ),
                                                          height: 8,
                                                          width: 8,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                            )),
                                        Text(
                                          "Male",
                                          style: TextStyleConst.hintTextStyle(
                                            ColorConst.hintGreyColor,
                                          ),
                                        ),
                                        const SizedBox(width: 0),
                                        GestureDetector(
                                            onTap: () {
                                              signUpController.currentIndex.value = 1;
                                            },
                                            child: Obx(
                                              () => signUpController.currentIndex.value == 1
                                                  ? Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: ColorConst.blueColor,
                                                      ),
                                                      child: Center(
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: ColorConst.whiteColor,
                                                          ),
                                                          height: 8,
                                                          width: 8,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                            )),
                                        Text(
                                          "Female",
                                          style: TextStyleConst.hintTextStyle(
                                            ColorConst.hintGreyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: height * 0.07),

                                  /// Login button
                                  CommonButton(
                                    textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                    onTap: () {
                                      signUpController.registerUser();
                                    },
                                    color: ColorConst.blueColor,
                                    text: "Submit",
                                    width: width,
                                    height: 50,
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already User?",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.hintGreyColor,
                                          width * 0.035,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          " Sign In",
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.blueColor,
                                            width * 0.035,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
