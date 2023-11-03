import '../controller/six_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SixScreen.
///
/// This class ensures that the SixController is created when the
/// SixScreen is first loaded.
class SixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SixController());
  }
}
