import '../controller/four_controller.dart';
import 'package:get/get.dart';

/// A binding class for the FourScreen.
///
/// This class ensures that the FourController is created when the
/// FourScreen is first loaded.
class FourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FourController());
  }
}
