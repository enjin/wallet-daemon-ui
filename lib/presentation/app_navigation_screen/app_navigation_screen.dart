import 'controller/app_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AppNavigationScreen extends GetWidget<AppNavigationController> {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          userName: "Zero".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.zeroScreen),
                        ),
                        _buildScreenTitle(
                          userName: "One".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.oneScreen),
                        ),
                        _buildScreenTitle(
                          userName: "Two".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.twoScreen),
                        ),
                        _buildScreenTitle(
                          userName: "Three".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.threeScreen),
                        ),
                        _buildScreenTitle(
                          userName: "Four".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.fourScreen),
                        ),
                        _buildScreenTitle(
                          userName: "Five".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.fiveScreen),
                        ),
                        _buildScreenTitle(
                          userName: "Six".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.sixScreen),
                        ),
                        _buildScreenTitle(
                          userName: "Seven".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.sevenScreen),
                        ),
                        _buildScreenTitle(
                          userName: "Eight".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.eightScreen),
                        ),
                        _buildScreenTitle(
                          userName: "Nine".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.nineScreen),
                        ),
                        _buildScreenTitle(
                          userName: "Ten".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.tenScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app."
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle({
    required String userName,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  userName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(String routeName) {
    Get.toNamed(routeName);
  }
}
