import 'package:daemon/presentation/lock_screen/controller/lock_controller.dart';
import 'package:daemon/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'localization/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.lazyPut(() => LockController());

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    center: true,
    size: Size(1200, 800),
    minimumSize: Size(1200, 800),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const EnjinApp());
}

class EnjinApp extends StatelessWidget {
  const EnjinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: theme,
      translations: AppLocalization(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      title: 'Enjin Wallet Daemon',
      initialRoute: AppPages.init,
      getPages: AppPages.routes,
    );
  }
}
