
import 'package:beamer/beamer.dart';
import 'package:enjin_wallet_daemon/screens/loading_screen.dart';
import 'package:enjin_wallet_daemon/screens/lock_screen.dart';
import 'package:enjin_wallet_daemon/screens/main_screen.dart';
import 'package:enjin_wallet_daemon/screens/onboard_screen.dart';
import 'package:enjin_wallet_daemon/services/daemon_service.dart';
import 'package:enjin_wallet_daemon/services/store_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:window_manager/window_manager.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<StoreService>(StoreService());
  getIt.registerSingleton<DaemonService>(DaemonService());

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
  EnjinApp({super.key});

  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const LoadingScreen(),
        '/first_main': (context, state, data) => Onboarding(
              key: GlobalKey<OnboardingState>(),
              steps: [
                OnboardingStep(
                  focusNode: getIt.get<StoreService>().focusNode,
                  titleText: "Welcome to Enjin Wallet Daemon",
                  bodyText:
                      "First, click in the \"Start\" button so we can make the initial setup.",
                )
              ],
              child: const MainScreen(),
            ),
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
