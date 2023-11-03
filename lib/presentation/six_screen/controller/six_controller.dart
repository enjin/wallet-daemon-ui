import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/presentation/six_screen/models/six_model.dart';

/// A controller class for the SixScreen.
///
/// This class manages the state of the SixScreen, including the
/// current sixModelObj
class SixController extends GetxController {
  Rx<SixModel> sixModelObj = SixModel().obs;

  SelectionPopupModel? selectedDropDownValue;

  onSelected(dynamic value) {
    for (var element in sixModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    sixModelObj.value.dropdownItemList.refresh();
  }
}
