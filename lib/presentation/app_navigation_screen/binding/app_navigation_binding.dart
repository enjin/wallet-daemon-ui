import '../controller/app_navigation_controller.dart';
import 'package:get/get.dart';

/// A binding class for the AppNavigationScreen.
///
/// This class ensures that the AppNavigationController is created when the
/// AppNavigationScreen is first loaded.
class AppNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppNavigationController());
  }
}
