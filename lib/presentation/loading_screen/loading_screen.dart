import 'package:daemon/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'controller/loading_controller.dart';

class LoadingScreen extends GetWidget<LoadingController> {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgZero),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: mediaQueryData.size.height / 2 - 150,
              child: CustomImageView(
                imagePath: 'assets/images/enjin_purple.png',
                // fit: BoxFit.contain,
                height: 180,
                width: 180,
              ),
            ),
            Positioned(
              top: mediaQueryData.size.height / 2 - 84,
              left: mediaQueryData.size.width / 2 - 154,
              child: Lottie.asset(
                'assets/animations/loading.json',
              ),
            ),
            Positioned(
              top: mediaQueryData.size.height / 2 + 84,
              child: const Text(
                'LOADING',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 8.40,
                ),
              ),
            ),
            Positioned(
              top: mediaQueryData.size.height / 2 + 114,
              child: Obx(
                () => Text(
                  controller.latestVersion.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 8.40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
