import '../controller/ten_controller.dart';
import 'package:get/get.dart';

/// A binding class for the TenScreen.
///
/// This class ensures that the TenController is created when the
/// TenScreen is first loaded.
class TenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenController());
  }
}
