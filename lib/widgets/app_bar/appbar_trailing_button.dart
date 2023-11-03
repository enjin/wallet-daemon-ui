import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/widgets/custom_elevated_button.dart';

// ignore: must_be_immutable
class AppbarTrailingButton extends StatelessWidget {
  AppbarTrailingButton({
    Key? key,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomElevatedButton(
          width: 103.h,
          text: "lbl_wallet_daemon2".tr,
          leftIcon: Container(
            margin: EdgeInsets.only(right: 6.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgMenu,
              height: 15.adaptSize,
              width: 15.adaptSize,
            ),
          ),
          buttonStyle: CustomButtonStyles.none,
          decoration:
              CustomButtonStyles.gradientDeepPurpleToDeepPurpleTL12Decoration,
        ),
      ),
    );
  }
}
