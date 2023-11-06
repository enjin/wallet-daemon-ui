import 'package:enjin_wallet_daemon/presentation/onboard_screen/controller/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/widgets/custom_elevated_button.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/custom_outlined_button.dart';

class OnboardScreen extends GetWidget<OnboardController> {
  OnboardScreen({super.key});

  final pageController = PageController(viewportFraction: 1.0, keepPage: true);
  int currentPage = 0;

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
        child: PageView.builder(
          itemCount: 5,
          controller: pageController,
          itemBuilder: (_, index) {
            switch (index) {
              case 1:
                return SigningPage(pageController: pageController);
              case 2:
                return SecurePage(pageController: pageController);
              case 3:
                return PasswordPage(pageController: pageController);
              default:
                return WelcomePage(pageController: pageController);
            }
          },
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  final PageController pageController;

  const WelcomePage({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgScreenshot20231102242x238,
          height: 387,
          width: 380,
        ),
        const SizedBox(
          width: 38,
        ),
        SizedBox(
          width: 446,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: 0,
                  count: 4,
                  effect: ScrollingDotsEffect(
                    spacing: 5.65,
                    activeDotColor: appTheme.deepPurple60001,
                    dotColor: appTheme.gray80001,
                    dotHeight: 6.v,
                    dotWidth: 6.h,
                  ),
                ),
              ),
              SizedBox(
                height: 38.v,
              ),
              SizedBox(
                width: 153.h,
                child: Text(
                  "msg_welcome_to_the_enjin".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontSize: 32,
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              SizedBox(
                width: 198.h,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "msg_the_best_blockchain2".tr,
                        style: CustomTextStyles.labelLarge13.copyWith(
                          fontSize: 22.0,
                        ),
                      ),
                      TextSpan(
                        text: "lbl_game_developers".tr,
                        style:
                            CustomTextStyles.labelLargeDeeppurple40013.copyWith(
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 63),
              CustomElevatedButton(
                height: 47,
                width: 158,
                text: "lbl_next".tr,
                buttonStyle: CustomButtonStyles.none,
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    curve: Curves.easeInOut,
                  );
                },
                decoration:
                    CustomButtonStyles.gradientDeepPurpleToDeepPurpleDecoration,
                buttonTextStyle: theme.textTheme.labelMedium!.copyWith(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SigningPage extends StatelessWidget {
  final PageController pageController;

  const SigningPage({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animations/check_list.json',
          height: 387,
          width: 380,
        ),
        const SizedBox(
          width: 38,
        ),
        SizedBox(
          width: 446,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: 1,
                  count: 4,
                  effect: ScrollingDotsEffect(
                    spacing: 5.65,
                    activeDotColor: appTheme.deepPurple60001,
                    dotColor: appTheme.gray80001,
                    dotHeight: 6.v,
                    dotWidth: 6.h,
                  ),
                ),
              ),
              SizedBox(
                height: 38.v,
              ),
              SizedBox(
                width: 446,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "msg_this_application2".tr,
                        style: theme.textTheme.titleMedium!
                            .copyWith(fontSize: 26.0),
                      ),
                      TextSpan(
                        text: "lbl_wallet_daemon".tr,
                        style: CustomTextStyles.titleMediumDeeppurple400!
                            .copyWith(fontSize: 26.0),
                      ),
                      TextSpan(
                        text: "msg_interfacing_with".tr,
                        style: theme.textTheme.titleMedium!
                            .copyWith(fontSize: 26.0),
                      ),
                      TextSpan(
                        text: "msg_automatic_signing".tr,
                        style: CustomTextStyles.titleMediumDeeppurple400!
                            .copyWith(fontSize: 26.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 63),
              Row(
                children: [
                  CustomOutlinedButton(
                    text: "lbl_back".tr,
                    height: 47,
                    width: 158,
                    buttonTextStyle: theme.textTheme.labelMedium!.copyWith(
                      fontSize: 18.0,
                    ),
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.easeInOut,
                      );
                    },
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  CustomElevatedButton(
                    height: 47,
                    width: 158,
                    text: "lbl_next".tr,
                    buttonStyle: CustomButtonStyles.none,
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.easeInOut,
                      );
                    },
                    decoration: CustomButtonStyles
                        .gradientDeepPurpleToDeepPurpleDecoration,
                    buttonTextStyle: theme.textTheme.labelMedium!.copyWith(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SecurePage extends StatelessWidget {
  final PageController pageController;

  const SecurePage({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animations/secure.json',
          height: 387,
          width: 380,
        ),
        const SizedBox(
          width: 38,
        ),
        SizedBox(
          width: 446,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: 2,
                  count: 4,
                  effect: ScrollingDotsEffect(
                    spacing: 5.65,
                    activeDotColor: appTheme.deepPurple60001,
                    dotColor: appTheme.gray80001,
                    dotHeight: 6.v,
                    dotWidth: 6.h,
                  ),
                ),
              ),
              SizedBox(
                height: 38.v,
              ),
              SizedBox(
                width: 446,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "lbl_to_start_you".tr,
                        style: theme.textTheme.titleMedium!
                            .copyWith(fontSize: 26.0),
                      ),
                      TextSpan(
                        text: "msg_must_set_a_password".tr,
                        style: CustomTextStyles.titleMediumDeeppurple400_1!
                            .copyWith(fontSize: 26.0),
                      ),
                      TextSpan(
                        text: "msg_to_encrypt_your".tr,
                        style: theme.textTheme.titleMedium!
                            .copyWith(fontSize: 26.0),
                      ),
                      TextSpan(
                        text: "msg_please_note_that".tr,
                        style: theme.textTheme.titleSmall!
                            .copyWith(fontSize: 26.0),
                      ),
                      TextSpan(
                        text: "msg_this_password_cannot".tr,
                        style: CustomTextStyles.titleSmallDeeppurple400!
                            .copyWith(fontSize: 26.0),
                      ),
                      TextSpan(
                        text: "lbl_if_lost".tr,
                        style: theme.textTheme.titleSmall!
                            .copyWith(fontSize: 26.0),
                      ),
                      TextSpan(
                        text: "lbl_not_even_by_us".tr,
                        style: theme.textTheme.labelLarge!
                            .copyWith(fontSize: 26.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 63),
              Row(
                children: [
                  CustomOutlinedButton(
                    text: "lbl_back".tr,
                    height: 47,
                    width: 158,
                    buttonTextStyle: theme.textTheme.labelMedium!.copyWith(
                      fontSize: 18.0,
                    ),
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.easeInOut,
                      );
                    },
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  CustomElevatedButton(
                    height: 47,
                    width: 158,
                    text: "lbl_next".tr,
                    buttonStyle: CustomButtonStyles.none,
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.easeInOut,
                      );
                    },
                    decoration: CustomButtonStyles
                        .gradientDeepPurpleToDeepPurpleDecoration,
                    buttonTextStyle: theme.textTheme.labelMedium!.copyWith(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PasswordPage extends StatelessWidget {
  final PageController pageController;

  PasswordPage({
    super.key,
    required this.pageController,
  });

  final controller = OnboardController.to;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 387,
          width: 340,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child: Lottie.asset(
                  'assets/animations/secure.json',
                  // height: 387,
                  width: 340,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Lottie.asset(
                  'assets/animations/password_field.json',
                  // height: 387,
                  width: 226,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 38,
        ),
        SizedBox(
          width: 446,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: 3,
                  count: 4,
                  effect: ScrollingDotsEffect(
                    spacing: 5.65,
                    activeDotColor: appTheme.deepPurple60001,
                    dotColor: appTheme.gray80001,
                    dotHeight: 6.v,
                    dotWidth: 6.h,
                  ),
                ),
              ),
              SizedBox(
                height: 38.v,
              ),
              SizedBox(
                width: 446,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "msg_your_password_must2".tr,
                            style: theme.textTheme.labelLarge!
                                .copyWith(fontSize: 26.0),
                          ),
                          TextSpan(
                            text: "msg_least_16_characters".tr,
                            style: CustomTextStyles.labelLargeDeeppurple400!
                                .copyWith(fontSize: 26.0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    // "lbl_bananananana".tr,
                    //CustomTextStyles.bodySmallInterWhiteA70010,
                    // "lbl_repeat_password".tr,
                    // style: CustomTextStyles.bodySmallInterGray80001,
                    // "msg_passwords_do".tr,
                    // style: CustomTextStyles.bodySmallInterRedA200,
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: 309,
                      child: Obx(
                        () => TextField(
                          cursorColor: Colors.white,
                          obscureText: controller.isPasswordObscure.value,
                          onChanged: controller.onChangedPassword,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            errorText: controller.hasPasswordError,
                            errorStyle: const TextStyle(
                              color: Color(0xFFFF5F57),
                            ),
                            hintText: "Input your password",
                            hintStyle: const TextStyle(
                              color: Color(0xFF4B4B4B),
                            ),
                            suffixIconConstraints: const BoxConstraints(
                              maxHeight: 26,
                            ),
                            suffixIcon: IconButton(
                              onPressed: controller.onPressedPasswordObscure,
                              icon: controller.isPasswordObscure.value
                                  ? Image.asset('assets/images/eye.png')
                                  : Image.asset('assets/images/eye_cut.png'),
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 10,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: appTheme.deepPurple60001,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: appTheme.deepPurple60001,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: appTheme.deepPurple60001,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: appTheme.deepPurple60001,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: 309,
                      child: Obx(
                        () => TextField(
                          cursorColor: Colors.white,
                          obscureText: controller.isRepeatObscure.value,
                          onChanged: controller.onChangedRepeat,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            errorText: controller.hasRepeatError,
                            errorStyle: const TextStyle(
                              color: Color(0xFFFF5F57),
                            ),
                            hintText: "Repeat the password",
                            hintStyle: const TextStyle(
                              color: Color(0xFF4B4B4B),
                            ),
                            suffixIconConstraints: const BoxConstraints(
                              maxHeight: 26,
                            ),
                            suffixIcon: IconButton(
                              onPressed: controller.onPressedRepeatObscure,
                              icon: controller.isRepeatObscure.value
                                  ? Image.asset('assets/images/eye.png')
                                  : Image.asset('assets/images/eye_cut.png'),
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 10,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: appTheme.deepPurple60001,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: appTheme.deepPurple60001,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: appTheme.deepPurple60001,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: appTheme.deepPurple60001,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 63),
              Row(
                children: [
                  CustomOutlinedButton(
                    text: "lbl_back".tr,
                    height: 47,
                    width: 158,
                    buttonTextStyle: theme.textTheme.labelMedium!.copyWith(
                      fontSize: 18.0,
                    ),
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.easeInOut,
                      );
                    },
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Obx(
                    () => CustomElevatedButton(
                      height: 47,
                      width: 158,
                      text: "lbl_next".tr,
                      buttonStyle: CustomButtonStyles.none,
                      onPressed: controller.setPassword,
                      isDisabled: controller.isNextDisabled,
                      decoration: CustomButtonStyles
                          .gradientDeepPurpleToDeepPurpleDecoration,
                      buttonTextStyle: theme.textTheme.labelMedium!.copyWith(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
