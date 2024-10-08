import 'package:daemon/core/app_export.dart';
import 'package:daemon/routes/app_pages.dart';

import '../../../services/store_service.dart';
import 'package:flutter/material.dart';

class OnboardController extends GetxController
    with GetTickerProviderStateMixin {
  static OnboardController get to => Get.find();

  late final AnimationController animationController;
  late final AnimationController anotherAnimationController;

  final pageController = PageController(viewportFraction: 1.0, keepPage: true);

  final password = ''.obs;
  final isPasswordObscure = true.obs;

  final repeat = ''.obs;
  final isRepeatObscure = true.obs;

  void onPressedPasswordObscure() =>
      isPasswordObscure.value = !isPasswordObscure.value;
  void onPressedRepeatObscure() =>
      isRepeatObscure.value = !isRepeatObscure.value;
  void onChangedPassword(text) => password.value = text;
  void onChangedRepeat(text) => repeat.value = text;

  String? get hasPasswordError =>
      password.value.length < 10 && password.value.isNotEmpty
          ? 'Password must be at least 10 characters long'
          : null;

  String? get hasRepeatError =>
      repeat.value.isNotEmpty && repeat.value != password.value
          ? 'Passwords do not match'
          : null;

  bool get isNextDisabled =>
      password.value.length < 10 || repeat.value != password.value;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this);
    anotherAnimationController = AnimationController(vsync: this);
  }

  @override
  void onClose() {
    animationController.dispose();
    anotherAnimationController.dispose();
    super.onClose();
  }

  Future<void> setPassword() async {
    if (password.value != repeat.value || password.value.length < 10) {
      return;
    }

    await StoreService.instance.init(password.value);

    Get.offNamed(Routes.main.nameToRoute());
  }
}
