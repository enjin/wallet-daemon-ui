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
  static String init = LoadingScreen.routeName;

  static final routes = [
    GetPage(
      name: LoadingScreen.routeName,
      page: () => const LoadingScreen(),
      title: 'Loading',
      binding: LoadingBiding(),
    ),
    GetPage(
      name: OnboardScreen.routeName,
      page: () => OnboardScreen(),
      title: 'Onboard',
      binding: OnboardBiding(),
    ),
    GetPage(
      name: MainScreen.routeName,
      page: () => MainScreen(),
      title: 'Main',
      binding: MainBinding(),
    ),
    GetPage(
      name: LockScreen.routeName,
      page: () => const LockScreen(),
      title: 'Lock',
      binding: LockBinding(),
    ),
  ];
}
