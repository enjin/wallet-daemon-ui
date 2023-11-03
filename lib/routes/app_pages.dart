import 'package:enjin_wallet_daemon/screens/loading/loading_biding.dart';
import 'package:enjin_wallet_daemon/screens/loading/loading_screen.dart';
import 'package:enjin_wallet_daemon/screens/lock/lock_screen.dart';
import 'package:enjin_wallet_daemon/screens/main/main_screen.dart';
import 'package:enjin_wallet_daemon/screens/onboard/onboard_screen.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static String init = Routes.loading.nameToRoute();

  static final routes = [
    GetPage(
      name: Routes.loading.nameToRoute(),
      page: () => const LoadingScreen(),
      title: 'Loading',
      binding: LoadingBinding(),
    ),
    GetPage(
      name: Routes.lock.nameToRoute(),
      page: () => const LockScreen(),
      title: 'Lock',
      binding: LoadingBinding(),
    ),
    GetPage(
      name: Routes.main.nameToRoute(),
      page: () => const MainScreen(),
      title: 'Main',
      binding: LoadingBinding(),
    ),
    GetPage(
      name: Routes.onboard.nameToRoute(),
      page: () => const OnboardScreen(),
      title: 'Onboard',
      binding: LoadingBinding(),
    ),
  ];
}
