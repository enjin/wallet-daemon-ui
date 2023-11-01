import 'package:beamer/beamer.dart';
import 'package:enjin_wallet_daemon/screens/loading_screen.dart';
import 'package:enjin_wallet_daemon/screens/lock_screen.dart';
import 'package:enjin_wallet_daemon/screens/main_screen.dart';
import 'package:enjin_wallet_daemon/screens/onboard_screen.dart';
import 'package:enjin_wallet_daemon/services/daemon_service.dart';
import 'package:enjin_wallet_daemon/services/store_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:window_manager/window_manager.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<StoreService>(StoreService());
  getIt.registerSingleton<DaemonService>(DaemonService());

  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
      // size: Size(1100, 800),
      // center: true,
      // backgroundColor: Colors.transparent,
      // skipTaskbar: false,
      // titleBarStyle: TitleBarStyle.hidden,
      );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(EnjinApp());
}

class EnjinApp extends StatelessWidget {
  EnjinApp({super.key});

  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const LoadingScreen(),
        '/main': (context, state, data) => const MainScreen(),
        '/lock': (context, state, data) => const LockScreen(),
        '/onboard': (context, state, data) => const OnboardScreen(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      title: 'Enjin Wallet Daemon',
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
