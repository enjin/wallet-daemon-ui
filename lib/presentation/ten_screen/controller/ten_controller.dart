import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/presentation/ten_screen/models/ten_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the TenScreen.
///
/// This class manages the state of the TenScreen, including the
/// current tenModelObj
class TenController extends GetxController {
  TextEditingController platformKeyController = TextEditingController();

  TextEditingController bananasBananasBananasBananasController =
      TextEditingController();

  Rx<TenModel> tenModelObj = TenModel().obs;

  @override
  void onClose() {
    super.onClose();
    platformKeyController.dispose();
    bananasBananasBananasBananasController.dispose();
  }
}
