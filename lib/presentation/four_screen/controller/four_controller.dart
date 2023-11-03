import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/presentation/four_screen/models/four_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the FourScreen.
///
/// This class manages the state of the FourScreen, including the
/// current fourModelObj
class FourController extends GetxController {
  TextEditingController passwordFieldController = TextEditingController();

  TextEditingController repeatPasswordFieldController = TextEditingController();

  Rx<FourModel> fourModelObj = FourModel().obs;

  @override
  void onClose() {
    super.onClose();
    passwordFieldController.dispose();
    repeatPasswordFieldController.dispose();
  }
}
