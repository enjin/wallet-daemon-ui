import '../controller/five_controller.dart';
import 'package:get/get.dart';

/// A binding class for the FiveScreen.
///
/// This class ensures that the FiveController is created when the
/// FiveScreen is first loaded.
class FiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FiveController());
  }
}
