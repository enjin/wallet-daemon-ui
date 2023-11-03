import 'controller/five_controller.dart';
import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_image.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_subtitle_four.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_subtitle_three.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_trailing_button.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/custom_app_bar.dart';
import 'package:enjin_wallet_daemon/widgets/custom_floating_text_field.dart';

// ignore_for_file: must_be_immutable
class FiveScreen extends GetWidget<FiveController> {
  const FiveScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: 800.h,
          child: SizedBox(
            height: 787.v,
            width: 800.h,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 600.v,
                    width: 800.h,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.v),
                    decoration: AppDecoration.fillBlueGray,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAppBar(),
                        SizedBox(height: 8.v),
                        Container(
                          height: 21.v,
                          width: 122.h,
                          margin: EdgeInsets.only(left: 14.h),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgRectangle3,
                                height: 21.v,
                                width: 122.h,
                                radius: BorderRadius.circular(
                                  5.h,
                                ),
                                alignment: Alignment.center,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 4.v),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "msg_enjin_platform_matrix".tr,
                                        style:
                                            CustomTextStyles.labelSmallMedium,
                                      ),
                                      CustomImageView(
                                        imagePath: ImageConstant.imgPolygon1,
                                        height: 3.v,
                                        width: 6.h,
                                        margin: EdgeInsets.only(
                                          left: 16.h,
                                          top: 2.v,
                                          bottom: 3.v,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.v),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 145.h,
                      vertical: 23.v,
                    ),
                    decoration: AppDecoration.fillBlack,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgGroup6,
                          height: 13.v,
                          width: 135.h,
                          margin: EdgeInsets.only(right: 12.h),
                        ),
                        SizedBox(height: 7.v),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: AppDecoration.outlineBlack900,
                              child: Text(
                                "lbl_run".tr,
                                style: CustomTextStyles.labelSmallGray60002,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 18.h),
                              decoration: AppDecoration.outlineBlack900,
                              child: Text(
                                "lbl_pause".tr,
                                style: CustomTextStyles.labelSmallGray60002,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15.h),
                              decoration: AppDecoration.outlineBlack900,
                              child: Text(
                                "lbl_lock".tr,
                                style: CustomTextStyles.labelSmallGray60002,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 14.h),
                              decoration: AppDecoration.outlineBlack900,
                              child: Text(
                                "lbl_settings".tr,
                                style: CustomTextStyles.labelSmallGray60002,
                              ),
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 25,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            margin: EdgeInsets.all(0),
                            color: appTheme.gray800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusStyle.roundedBorder6,
                            ),
                            child: Container(
                              height: 261.v,
                              width: 267.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 22.h,
                                vertical: 16.v,
                              ),
                              decoration:
                                  AppDecoration.outlineBlack9001.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder6,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: 28.v,
                                        right: 5.h,
                                        bottom: 133.v,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.h,
                                        vertical: 4.v,
                                      ),
                                      decoration:
                                          AppDecoration.fillWhiteA.copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder6,
                                      ),
                                      child: Row(
                                        children: [
                                          CustomImageView(
                                            imagePath: ImageConstant.imgWarning,
                                            height: 40.adaptSize,
                                            width: 40.adaptSize,
                                            margin: EdgeInsets.only(
                                              top: 8.v,
                                              bottom: 7.v,
                                            ),
                                          ),
                                          Container(
                                            width: 133.h,
                                            margin: EdgeInsets.only(
                                              left: 10.h,
                                              top: 4.v,
                                            ),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "msg_before_using_you2"
                                                            .tr,
                                                    style: CustomTextStyles
                                                        .interGray80001Medium,
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "msg_generate_a_wallet"
                                                            .tr,
                                                    style: CustomTextStyles
                                                        .interGray80001Bold
                                                        .copyWith(
                                                      height: 1.60,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "msg_for_extra_security"
                                                            .tr,
                                                    style: CustomTextStyles
                                                        .interGray80001Medium,
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "msg_set_your_own_password"
                                                            .tr,
                                                    style: CustomTextStyles
                                                        .interGray80001Bold,
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "msg_minimum_of_8_characters"
                                                            .tr,
                                                    style: CustomTextStyles
                                                        .interGray80001Bold6,
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "msg_or_let_us_generate"
                                                            .tr,
                                                    style: CustomTextStyles
                                                        .interGray80001Bold,
                                                  ),
                                                ],
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 5.h),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "lbl_wallet_creation".tr,
                                            style: theme.textTheme.titleSmall,
                                          ),
                                          SizedBox(height: 90.v),
                                          Text(
                                            "lbl_your_password".tr,
                                            style: CustomTextStyles
                                                .interWhiteA700Bold,
                                          ),
                                          SizedBox(height: 4.v),
                                          Container(
                                            height: 16.v,
                                            width: 208.h,
                                            margin: EdgeInsets.only(left: 8.h),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 9.h,
                                                      top: 3.v,
                                                    ),
                                                    child: Text(
                                                      "msg_bananas_bananas".tr,
                                                      style: CustomTextStyles
                                                          .interWhiteA700,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    height: 16.v,
                                                    width: 208.h,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 6.h,
                                                      vertical: 4.v,
                                                    ),
                                                    decoration: AppDecoration
                                                        .outlineWhiteA700
                                                        .copyWith(
                                                      borderRadius:
                                                          BorderRadiusStyle
                                                              .roundedBorder3,
                                                    ),
                                                    child: CustomImageView(
                                                      imagePath: ImageConstant
                                                          .imgGroupWhiteA700,
                                                      height: 5.v,
                                                      width: 7.h,
                                                      alignment:
                                                          Alignment.topRight,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 11.v),
                                          Text(
                                            "msg_repeat_your_password".tr,
                                            style: CustomTextStyles
                                                .interWhiteA700Bold,
                                          ),
                                          SizedBox(height: 4.v),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.h),
                                            child: CustomFloatingTextField(
                                              width: 208.h,
                                              controller:
                                                  controller.passwordController,
                                              labelText: "msg".tr,
                                              labelStyle:
                                                  CustomTextStyles.interRedA200,
                                              hintText: "msg".tr,
                                              textInputAction:
                                                  TextInputAction.done,
                                              suffix: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 7.h),
                                                child: CustomImageView(
                                                  imagePath:
                                                      ImageConstant.imgSearch,
                                                  height: 4.v,
                                                  width: 7.h,
                                                ),
                                              ),
                                              suffixConstraints: BoxConstraints(
                                                maxHeight: 27.v,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 17.v),
                                          Container(
                                            height: 18.v,
                                            width: 208.h,
                                            margin: EdgeInsets.only(left: 8.h),
                                            child: Stack(
                                              alignment: Alignment.centerRight,
                                              children: [
                                                CustomImageView(
                                                  imagePath:
                                                      ImageConstant.imgGroup10,
                                                  height: 18.v,
                                                  width: 208.h,
                                                  alignment: Alignment.center,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            37.h,
                                                            5.v,
                                                            13.h,
                                                            4.v),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "lbl_done".tr,
                                                          style: CustomTextStyles
                                                              .interWhiteA700Bold,
                                                        ),
                                                        Text(
                                                          "msg_generate_password"
                                                              .tr,
                                                          style: CustomTextStyles
                                                              .interBluegray90001,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 74,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: Container(
        height: 40.v,
        width: 316.55002.h,
        margin: EdgeInsets.only(left: 14.h),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 40.v,
                width: 304.h,
                margin: EdgeInsets.only(left: 12.h),
                decoration: BoxDecoration(
                  color: appTheme.gray400,
                  borderRadius: BorderRadius.circular(
                    6.h,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.black900.withOpacity(0.25),
                      spreadRadius: 2.h,
                      blurRadius: 2.h,
                      offset: Offset(
                        0,
                        2.51,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(right: 14.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                  vertical: 7.v,
                ),
                decoration: AppDecoration.outlineBlack.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderTL6,
                ),
                child: Row(
                  children: [
                    AppbarImage(
                      imagePath: ImageConstant.imgEnjinmatrixchaincanary,
                      margin: EdgeInsets.only(bottom: 2.v),
                    ),
                    AppbarSubtitleFour(
                      text: "lbl".tr,
                      margin: EdgeInsets.only(
                        left: 11.h,
                        top: 15.v,
                      ),
                    ),
                    AppbarSubtitleThree(
                      text: "msg_wallet_address_none".tr,
                      margin: EdgeInsets.only(
                        top: 2.v,
                        right: 158.h,
                        bottom: 13.v,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        AppbarTrailingButton(
          margin: EdgeInsets.fromLTRB(21.h, 1.v, 21.h, 13.v),
        ),
      ],
    );
  }
}
