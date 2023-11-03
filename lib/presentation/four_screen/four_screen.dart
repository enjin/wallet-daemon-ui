import 'controller/four_controller.dart';
import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/widgets/custom_elevated_button.dart';
import 'package:enjin_wallet_daemon/widgets/custom_outlined_button.dart';
import 'package:enjin_wallet_daemon/widgets/custom_text_form_field.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore_for_file: must_be_immutable
class FourScreen extends GetWidget<FourController> {
  const FourScreen({Key? key})
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
            height: 600.v,
            width: 800.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 478.v,
                    width: 800.h,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 800.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 152.h,
                      vertical: 188.v,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          ImageConstant.imgZero,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 174.v,
                          width: 141.h,
                          margin: EdgeInsets.only(
                            top: 15.v,
                            bottom: 33.v,
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgImage3,
                                height: 124.v,
                                width: 104.h,
                                alignment: Alignment.topCenter,
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgImage4,
                                height: 54.v,
                                width: 141.h,
                                alignment: Alignment.bottomCenter,
                              ),
                            ],
                          ),
                        )
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
  Widget _buildDoneButton() {
    return Expanded(
      child: CustomElevatedButton(
        height: 29.v,
        text: "lbl_done".tr,
        margin: EdgeInsets.only(left: 5.h),
        rightIcon: Container(
          margin: EdgeInsets.only(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              6.h,
            ),
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgRectangle13,
            height: 29.v,
            width: 99.h,
          ),
        ),
        buttonStyle: CustomButtonStyles.none,
        decoration: CustomButtonStyles.gradientDeepPurpleToDeepPurpleDecoration,
        buttonTextStyle: theme.textTheme.labelMedium!,
      ),
    );
  }
}
