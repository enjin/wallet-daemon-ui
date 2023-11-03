import 'controller/nine_controller.dart';
import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/core/utils/validation_functions.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_image.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_subtitle_four.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_subtitle_three.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_trailing_button.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/custom_app_bar.dart';
import 'package:enjin_wallet_daemon/widgets/custom_drop_down.dart';
import 'package:enjin_wallet_daemon/widgets/custom_text_form_field.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

// ignore_for_file: must_be_immutable
class NineScreen extends GetWidget<NineController> {
  NineScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: 800.h,
            child: SizedBox(
              height: 600.v,
              width: 800.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 13.v),
                      decoration: AppDecoration.fillBlueGray,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAppBar(),
                          SizedBox(height: 8.v),
                          Padding(
                            padding: EdgeInsets.only(left: 14.h),
                            child: CustomDropDown(
                              width: 122.h,
                              icon: Container(
                                margin: EdgeInsets.only(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5.h,
                                  ),
                                ),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgRectangle3,
                                  height: 21.v,
                                  width: 122.h,
                                ),
                              ),
                              hintText: "msg_enjin_platform_matrix".tr,
                              items: controller
                                  .nineModelObj.value.dropdownItemList!.value,
                              onChanged: (value) {
                                controller.onSelected(value);
                              },
                            ),
                          ),
                          SizedBox(height: 13.v),
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
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 21.h,
                        vertical: 22.v,
                      ),
                      decoration: AppDecoration.fillBlack,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgGroup6WhiteA700,
                            height: 13.v,
                            width: 135.h,
                            margin: EdgeInsets.only(right: 136.h),
                          ),
                          SizedBox(height: 7.v),
                          Padding(
                            padding: EdgeInsets.only(right: 124.h),
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
                          SizedBox(height: 14.v),
                          Container(
                            width: 161.h,
                            margin: EdgeInsets.only(left: 596.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 13.h,
                              vertical: 15.v,
                            ),
                            decoration: AppDecoration.outlineBlack9001.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder6,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "msg_enjin_matrixchain".tr,
                                    style: CustomTextStyles.interWhiteA700Bold,
                                  ),
                                ),
                                SizedBox(height: 5.v),
                                _buildEnjinMatrixchain(),
                                SizedBox(height: 13.v),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "msg_canary_matrixchain".tr,
                                    style: CustomTextStyles.interWhiteA700Bold,
                                  ),
                                ),
                                SizedBox(height: 5.v),
                                _buildEnjinIoBananasCo(),
                                SizedBox(height: 13.v),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 103.h,
                                    margin: EdgeInsets.only(right: 30.h),
                                    child: Text(
                                      "msg_generated_wallet".tr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles.interWhiteA700Bold
                                          .copyWith(
                                        height: 1.45,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.v),
                                _buildBananasbananasbananasbananas(),
                                SizedBox(height: 12.v),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 93.h,
                                    child: Text(
                                      "msg_generated_wallet2".tr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles.interWhiteA700Bold
                                          .copyWith(
                                        height: 1.45,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.v),
                                _buildPassword(),
                                SizedBox(height: 13.v),
                                SizedBox(
                                  height: 18.v,
                                  width: 125.h,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgGroup10,
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
                          SizedBox(height: 14.v),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

  /// Section Widget
  Widget _buildEnjinMatrixchain() {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.h,
        right: 3.h,
      ),
      child: CustomTextFormField(
        controller: controller.enjinMatrixchainController,
        hintText: "msg_input_your_platform".tr,
      ),
    );
  }

  /// Section Widget
  Widget _buildEnjinIoBananasCo() {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.h,
        right: 3.h,
      ),
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
        child: CustomTextFormField(
          controller: controller.enjinIoBananasCoController,
          hintText: "msg_enjin_io_bananas_co".tr,
          borderDecoration: TextFormFieldStyleHelper.outline,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBananasbananasbananasbananas() {
    return Padding(
      padding: EdgeInsets.only(
        left: 5.h,
        right: 3.h,
      ),
      child: CustomTextFormField(
        controller: controller.bananasbananasbananasbananasController,
        hintText: "msg_bananas_bananas".tr,
        suffix: Container(
          padding: EdgeInsets.fromLTRB(30.h, 5.v, 3.h, 5.v),
          margin: EdgeInsets.only(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              3.h,
            ),
            border: Border.all(
              color: appTheme.whiteA700,
              width: 1.h,
            ),
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgGroupWhiteA700,
            height: 5.v,
            width: 7.h,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 16.v,
        ),
        contentPadding: EdgeInsets.only(
          left: 5.h,
          top: 3.v,
          bottom: 3.v,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPassword() {
    return Padding(
      padding: EdgeInsets.only(
        left: 5.h,
        right: 3.h,
      ),
      child: Obx(
        () => CustomTextFormField(
          controller: controller.passwordController,
          hintText: "msg".tr,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          suffix: InkWell(
            onTap: () {
              controller.isShowPassword.value =
                  !controller.isShowPassword.value;
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(30.h, 5.v, 4.h, 6.v),
              margin: EdgeInsets.only(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  3.h,
                ),
                border: Border.all(
                  color: appTheme.whiteA700,
                  width: 1.h,
                ),
              ),
              child: CustomImageView(
                imagePath: ImageConstant.imgSearch,
                height: 4.v,
                width: 7.h,
              ),
            ),
          ),
          suffixConstraints: BoxConstraints(
            maxHeight: 16.v,
          ),
          validator: (value) {
            if (value == null || (!isValidPassword(value, isRequired: true))) {
              return "err_msg_please_enter_valid_password".tr;
            }
            return null;
          },
          obscureText: controller.isShowPassword.value,
          contentPadding: EdgeInsets.only(
            left: 5.h,
            top: 3.v,
            bottom: 3.v,
          ),
        ),
      ),
    );
  }
}
