import 'controller/ten_controller.dart';
import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_image.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_subtitle_four.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_subtitle_three.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_trailing_button.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/custom_app_bar.dart';
import 'package:enjin_wallet_daemon/widgets/custom_text_form_field.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

// ignore_for_file: must_be_immutable
class TenScreen extends GetWidget<TenController> {
  const TenScreen({Key? key})
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
            height: 656.v,
            width: 800.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 598.v,
                    width: 800.h,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.v),
                    decoration: AppDecoration.fillBlueGray,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAppBar(),
                        SizedBox(height: 42.v),
                        Container(
                          width: 711.h,
                          margin: EdgeInsets.only(
                            left: 25.h,
                            right: 63.h,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_764087z2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_wallets_to_derive".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_791271z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn2".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_transactions".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "\n".tr,
                                  style: theme.textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_26_196135z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "     ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_info".tr,
                                  style: CustomTextStyles.bodySmallGreenA400,
                                ),
                                TextSpan(
                                  text: "    ".tr,
                                ),
                                TextSpan(
                                  text: "msg_jsonrpsee_clien".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_connection_established".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_764087z2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_wallets_to_derive".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_791271z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn2".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_transactions".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "\n".tr,
                                  style: theme.textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_26_196135z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "     ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_info".tr,
                                  style: CustomTextStyles.bodySmallGreenA400,
                                ),
                                TextSpan(
                                  text: "    ".tr,
                                ),
                                TextSpan(
                                  text: "msg_jsonrpsee_clien".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_connection_established".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_764087z2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_wallets_to_derive".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_791271z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn2".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_transactions".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "\n".tr,
                                  style: theme.textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_26_196135z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "     ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_info".tr,
                                  style: CustomTextStyles.bodySmallGreenA400,
                                ),
                                TextSpan(
                                  text: "    ".tr,
                                ),
                                TextSpan(
                                  text: "msg_jsonrpsee_clien".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_connection_established2".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_764087z2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_wallets_to_deriveap".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_791271z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn2".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_transactions".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "\n".tr,
                                  style: theme.textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_26_196135z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "     ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_info".tr,
                                  style: CustomTextStyles.bodySmallGreenA400,
                                ),
                                TextSpan(
                                  text: "    ".tr,
                                ),
                                TextSpan(
                                  text: "msg_jsonrpsee_clien".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_connection_established".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_764087z2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_wallets_to_derive".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_791271z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn2".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_transactions".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "\n".tr,
                                  style: theme.textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_26_196135z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "     ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_info".tr,
                                  style: CustomTextStyles.bodySmallGreenA400,
                                ),
                                TextSpan(
                                  text: "    ".tr,
                                ),
                                TextSpan(
                                  text: "msg_jsonrpsee_clien".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_connection_established".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_764087z2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_wallets_to_derive".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_791271z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn2".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_transactions".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "\n".tr,
                                  style: theme.textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_26_196135z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "     ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_info".tr,
                                  style: CustomTextStyles.bodySmallGreenA400,
                                ),
                                TextSpan(
                                  text: "    ".tr,
                                ),
                                TextSpan(
                                  text: "msg_jsonrpsee_clien".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_connection_established".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_764087z2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_wallets_to_derive".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_791271z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn2".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_transactions".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "\n".tr,
                                  style: theme.textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_26_196135z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "     ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_info".tr,
                                  style: CustomTextStyles.bodySmallGreenA400,
                                ),
                                TextSpan(
                                  text: "    ".tr,
                                ),
                                TextSpan(
                                  text: "msg_jsonrpsee_clien".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_connection_established".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_764087z2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_wallets_to_derive".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_25_791271z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "  ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_warn2".tr,
                                  style: CustomTextStyles.bodySmallYellowA400,
                                ),
                                TextSpan(
                                  text: "   ".tr,
                                ),
                                TextSpan(
                                  text: "msg_wallet_lib_jobs2".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_no_transactions".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                                TextSpan(
                                  text: "\n".tr,
                                  style: theme.textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: "msg_2023_11_02t01_07_26_196135z".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "     ".tr,
                                ),
                                TextSpan(
                                  text: "lbl_info".tr,
                                  style: CustomTextStyles.bodySmallGreenA400,
                                ),
                                TextSpan(
                                  text: "    ".tr,
                                ),
                                TextSpan(
                                  text: "msg_jsonrpsee_clien".tr,
                                  style: CustomTextStyles.bodySmallGray600,
                                ),
                                TextSpan(
                                  text: "msg_connection_established3".tr,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 53.v),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 13.h,
                      vertical: 23.v,
                    ),
                    decoration: AppDecoration.fillBlack,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgGroup6WhiteA700,
                          height: 13.v,
                          width: 135.h,
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 144.h),
                        ),
                        SizedBox(height: 7.v),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 131.h),
                            child: Row(
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
                                    style: theme.textTheme.labelSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 7.v),
                        SizedBox(
                          height: 21.v,
                          width: 122.h,
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
                                  padding:
                                      EdgeInsets.fromLTRB(9.h, 6.v, 9.h, 4.v),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "lbl_custom_endpoint".tr,
                                        style:
                                            CustomTextStyles.labelSmallMedium,
                                      ),
                                      CustomImageView(
                                        imagePath: ImageConstant.imgPolygon1,
                                        height: 3.v,
                                        width: 6.h,
                                        margin: EdgeInsets.only(
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
                        Container(
                          width: 161.h,
                          margin: EdgeInsets.only(right: 611.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 13.h,
                            vertical: 14.v,
                          ),
                          decoration: AppDecoration.outlineBlack9001.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "msg_your_platform_endpoint".tr,
                                  style: CustomTextStyles.interWhiteA700Bold,
                                ),
                              ),
                              SizedBox(height: 5.v),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 4.h,
                                  right: 3.h,
                                ),
                                child: CustomTextFormField(
                                  controller: controller.platformKeyController,
                                  hintText: "msg_input_your_platform".tr,
                                ),
                              ),
                              SizedBox(height: 12.v),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "msg_authentication_token".tr,
                                  style: CustomTextStyles.interWhiteA700Bold,
                                ),
                              ),
                              SizedBox(height: 5.v),
                              SizedBox(
                                height: 16.v,
                                width: 125.h,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 6.h,
                                          top: 3.v,
                                        ),
                                        child: Text(
                                          "msg_enjin_io_bananas_co".tr,
                                          style:
                                              CustomTextStyles.interWhiteA700,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: OutlineGradientButton(
                                        padding: EdgeInsets.only(
                                          left: 1.h,
                                          top: 1.v,
                                          right: 1.h,
                                          bottom: 1.v,
                                        ),
                                        strokeWidth: 1.h,
                                        gradient: LinearGradient(
                                          begin: Alignment(0.5, 0),
                                          end: Alignment(0.5, 1),
                                          colors: [
                                            appTheme.deepPurple400,
                                            appTheme.deepPurple60001,
                                          ],
                                        ),
                                        corners: Corners(
                                          topLeft: Radius.circular(3),
                                          topRight: Radius.circular(3),
                                          bottomLeft: Radius.circular(3),
                                          bottomRight: Radius.circular(3),
                                        ),
                                        child: Container(
                                          height: 16.v,
                                          width: 125.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              3.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 17.v),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "msg_blockchain_rpc_node".tr,
                                  style: CustomTextStyles.interWhiteA700Bold,
                                ),
                              ),
                              SizedBox(height: 11.v),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 5.h,
                                  right: 3.h,
                                ),
                                child: CustomTextFormField(
                                  controller: controller
                                      .bananasBananasBananasBananasController,
                                  hintText: "msg_bananas_bananas".tr,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              SizedBox(height: 13.v),
                              SizedBox(
                                height: 18.v,
                                width: 125.h,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          ImageConstant.imgGroup10WhiteA700,
                                      height: 18.v,
                                      width: 125.h,
                                      alignment: Alignment.center,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            18.h, 5.v, 16.h, 4.v),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "lbl_apply".tr,
                                              style: CustomTextStyles
                                                  .interWhiteA700Bold,
                                            ),
                                            Text(
                                              "lbl_cancel".tr,
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
                        SizedBox(height: 8.v),
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
                  color: appTheme.red300,
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
                      text: "msg_efrrzmui6vmnqmx".tr,
                      margin: EdgeInsets.only(
                        left: 11.h,
                        top: 15.v,
                      ),
                    ),
                    AppbarSubtitleThree(
                      text: "msg_wallet_address_paused".tr,
                      margin: EdgeInsets.only(
                        top: 2.v,
                        right: 149.h,
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
