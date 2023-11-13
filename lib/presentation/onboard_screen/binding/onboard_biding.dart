import 'package:daemon/presentation/onboard_screen/controller/onboard_controller.dart';
import 'package:get/get.dart';

class OnboardBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardController());
  }
}
