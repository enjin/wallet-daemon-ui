import '../controller/eight_controller.dart';
import 'package:get/get.dart';

/// A binding class for the EightScreen.
///
/// This class ensures that the EightController is created when the
/// EightScreen is first loaded.
class EightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EightController());
  }
}
