import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/presentation/eight_screen/models/eight_model.dart';

/// A controller class for the EightScreen.
///
/// This class manages the state of the EightScreen, including the
/// current eightModelObj
class EightController extends GetxController {
  Rx<EightModel> eightModelObj = EightModel().obs;

  SelectionPopupModel? selectedDropDownValue;

  onSelected(dynamic value) {
    for (var element in eightModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    eightModelObj.value.dropdownItemList.refresh();
  }
}
