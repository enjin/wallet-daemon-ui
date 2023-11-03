import '../controller/nine_controller.dart';
import 'package:get/get.dart';

/// A binding class for the NineScreen.
///
/// This class ensures that the NineController is created when the
/// NineScreen is first loaded.
class NineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NineController());
  }
}
