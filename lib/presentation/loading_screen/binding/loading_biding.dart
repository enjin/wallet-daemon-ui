import '../controller/loading_controller.dart';
import 'package:get/get.dart';

class LoadingBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoadingController());
  }
}
