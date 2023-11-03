import '../controller/seven_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SevenScreen.
///
/// This class ensures that the SevenController is created when the
/// SevenScreen is first loaded.
class SevenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SevenController());
  }
}
