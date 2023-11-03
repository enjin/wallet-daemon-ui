import 'package:lottie/lottie.dart';

import 'controller/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';

class LoadingScreen extends GetWidget<LoadingController> {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height,
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgZero),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgSymbolOnlyPurple,
              height: 146.adaptSize,
              width: 146.adaptSize,
            ),
            Lottie.asset(
              'assets/animations/loading.json',
            ),
            const Text(
              'LOADING',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
                letterSpacing: 8.40,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
