import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/presentation/seven_screen/models/seven_model.dart';

/// A controller class for the SevenScreen.
///
/// This class manages the state of the SevenScreen, including the
/// current sevenModelObj
class SevenController extends GetxController {
  Rx<SevenModel> sevenModelObj = SevenModel().obs;

  SelectionPopupModel? selectedDropDownValue;

  onSelected(dynamic value) {
    for (var element in sevenModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    sevenModelObj.value.dropdownItemList.refresh();
  }
}
