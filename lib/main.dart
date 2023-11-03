import 'package:enjin_wallet_daemon/routes/app_pages.dart';
import 'package:enjin_wallet_daemon/screens/loading/loading_controller.dart';
import 'package:enjin_wallet_daemon/screens/loading/loading_screen.dart';
import 'package:enjin_wallet_daemon/screens/lock/lock_screen.dart';
import 'package:enjin_wallet_daemon/screens/main/main_screen.dart';
import 'package:enjin_wallet_daemon/screens/onboard/onboard_screen.dart';
import 'package:enjin_wallet_daemon/services/daemon_service.dart';
import 'package:enjin_wallet_daemon/services/store_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:window_manager/window_manager.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<StoreService>(StoreService());
  getIt.registerSingleton<DaemonService>(DaemonService());

  // Get.lazyPut<LoadingController>(() => LoadingController());
  Get.lazyPut<LoadingController>(() => LoadingController(), fenix: true);

  // Must add this line.
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

  runApp(EnjinApp());
}

class EnjinApp extends StatelessWidget {
  const EnjinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Enjin Wallet Daemon',
      initialRoute: AppPages.init,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: "Hauora",
            color: Color(0xFF434A60),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
