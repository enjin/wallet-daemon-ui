import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/presentation/five_screen/models/five_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the FiveScreen.
///
/// This class manages the state of the FiveScreen, including the
/// current fiveModelObj
class FiveController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  Rx<FiveModel> fiveModelObj = FiveModel().obs;

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
  }
}
