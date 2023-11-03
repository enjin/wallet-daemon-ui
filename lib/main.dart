import 'package:enjin_wallet_daemon/routes/app_pages.dart';
import 'package:enjin_wallet_daemon/services/daemon_service.dart';
import 'package:enjin_wallet_daemon/services/store_service.dart';
import 'package:enjin_wallet_daemon/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:window_manager/window_manager.dart';

import 'localization/app_localization.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<StoreService>(StoreService());
  getIt.registerSingleton<DaemonService>(DaemonService());

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
