import '../controller/lock_controller.dart';
import 'package:get/get.dart';

class LockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LockController());
  }
}
