import 'package:daemon/core/app_export.dart';
import 'package:daemon/routes/app_pages.dart';
import 'package:window_manager/window_manager.dart';

import '../../../main.dart';
import '../../../services/daemon_service.dart';
import '../../../services/store_service.dart';

class LockController extends GetxController with WindowListener {
  static LockController get to => Get.find();

  final hasError = false.obs;
  final password = ''.obs;
  final isPasswordObscure = true.obs;

  void onPressedPasswordObscure() =>
      isPasswordObscure.value = !isPasswordObscure.value;

  void onChangedPassword(text) {
    password.value = text;
    hasError.value = false;
  }

  String? get hasPasswordError =>
      password.value.isNotEmpty && hasError.value ? 'Invalid Password' : null;

  @override
  void onInit() {
    super.onInit();
    windowManager.addListener(this);
  }

  @override
  void onClose() {
    super.onClose();
    windowManager.removeListener(this);
  }

  @override
  void onWindowClose() {
    getIt.get<DaemonService>().stopWallet();
  }

  Future<void> checkPassword() async {
    if (password.value.isEmpty) {
      return;
    }

    if (await getIt.get<StoreService>().init(password.value)) {
      Get.offNamed(Routes.main.nameToRoute());

      return;
    }

    hasError.value = true;
  }
}
