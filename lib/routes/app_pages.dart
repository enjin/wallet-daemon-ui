import 'package:enjin_wallet_daemon/presentation/loading_screen/binding/loading_biding.dart';
import 'package:enjin_wallet_daemon/presentation/loading_screen/loading_screen.dart';
import 'package:enjin_wallet_daemon/presentation/lock_screen/binding/lock_binding.dart';
import 'package:enjin_wallet_daemon/presentation/lock_screen/lock_screen.dart';
import 'package:enjin_wallet_daemon/presentation/main_screen/binding/main_binding.dart';
import 'package:enjin_wallet_daemon/presentation/main_screen/main_screen.dart';
import 'package:enjin_wallet_daemon/presentation/onboard_screen/binding/onboard_biding.dart';
import 'package:enjin_wallet_daemon/presentation/onboard_screen/onboard_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static String init = Routes.loading.nameToRoute();

  static final routes = [
    GetPage(
      name: Routes.loading.nameToRoute(),
      page: () => const LoadingScreen(),
      title: 'Loading',
      binding: LoadingBiding(),
    ),
    GetPage(
      name: Routes.onboard.nameToRoute(),
      page: () => OnboardScreen(),
      title: 'Onboard',
      binding: OnboardBiding(),
    ),
    GetPage(
      name: Routes.main.nameToRoute(),
      page: () => MainScreen(),
      title: 'Main',
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.lock.nameToRoute(),
      page: () => const LockScreen(),
      title: 'Lock',
      binding: LockBinding(),
    ),
  ];
}
