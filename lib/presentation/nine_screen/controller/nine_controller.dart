import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/presentation/nine_screen/models/nine_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the NineScreen.
///
/// This class manages the state of the NineScreen, including the
/// current nineModelObj
class NineController extends GetxController {
  TextEditingController enjinMatrixchainController = TextEditingController();

  TextEditingController enjinIoBananasCoController = TextEditingController();

  TextEditingController bananasbananasbananasbananasController =
      TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<NineModel> nineModelObj = NineModel().obs;

  Rx<bool> isShowPassword = true.obs;

  SelectionPopupModel? selectedDropDownValue;

  @override
  void onClose() {
    super.onClose();
    enjinMatrixchainController.dispose();
    enjinIoBananasCoController.dispose();
    bananasbananasbananasbananasController.dispose();
    passwordController.dispose();
  }

  onSelected(dynamic value) {
    for (var element in nineModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    nineModelObj.value.dropdownItemList.refresh();
  }
}
