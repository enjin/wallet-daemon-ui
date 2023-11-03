import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTitle extends StatelessWidget {
  AppbarTitle({
    Key? key,
    required this.text,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String text;

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
        child: Container(
          decoration: AppDecoration.outlineBlack900,
          child: Text(
            text,
            style: CustomTextStyles.labelMediumGray40001.copyWith(
              color: appTheme.gray40001,
            ),
          ),
        ),
      ),
    );
  }
}
