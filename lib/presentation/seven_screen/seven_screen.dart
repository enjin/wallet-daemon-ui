import 'controller/seven_controller.dart';
import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_image.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_subtitle_four.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_subtitle_three.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_title.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/appbar_trailing_button_one.dart';
import 'package:enjin_wallet_daemon/widgets/app_bar/custom_app_bar.dart';
import 'package:enjin_wallet_daemon/widgets/custom_drop_down.dart';

// ignore_for_file: must_be_immutable
class SevenScreen extends GetWidget<SevenController> {
  const SevenScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
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
                    height: 599.v,
                    width: 800.h,
                    decoration: BoxDecoration(
                      color: appTheme.blueGray900,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 14.h,
                      right: 21.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAppBar(),
                        SizedBox(height: 8.v),
                        CustomDropDown(
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
                              .sevenModelObj.value.dropdownItemList!.value,
                          onChanged: (value) {
                            controller.onSelected(value);
                          },
                        ),
                        SizedBox(height: 13.v),
                        Container(
                          width: 711.h,
                          margin: EdgeInsets.only(
                            left: 10.h,
                            right: 41.h,
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
      title: Padding(
        padding: EdgeInsets.only(left: 14.h),
        child: Row(
          children: [
            SizedBox(
              height: 40.v,
              width: 316.55002.h,
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
            AppbarTitle(
              text: "lbl_run".tr,
              margin: EdgeInsets.only(
                left: 171.h,
                top: 28.v,
              ),
            ),
            AppbarSubtitleTwo(
              text: "lbl_pause".tr,
              margin: EdgeInsets.only(
                left: 16.h,
                top: 29.v,
              ),
            ),
            AppbarSubtitleTwo(
              text: "lbl_lock".tr,
              margin: EdgeInsets.only(
                left: 15.h,
                top: 29.v,
              ),
            ),
            AppbarSubtitleTwo(
              text: "lbl_settings".tr,
              margin: EdgeInsets.only(
                left: 14.h,
                top: 29.v,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          height: 23.54.v,
          width: 137.h,
          margin: EdgeInsets.only(
            left: 21.h,
            top: 5.v,
            right: 10.h,
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgGroup9,
                height: 17.v,
                width: 137.h,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 6.v),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgImage2,
                height: 16.v,
                width: 11.h,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                  left: 6.h,
                  top: 7.v,
                  right: 119.h,
                ),
              ),
            ],
          ),
        ),
        AppbarTrailingButtonOne(
          margin: EdgeInsets.fromLTRB(33.h, 1.v, 31.h, 2.v),
        ),
      ],
    );
  }
}
