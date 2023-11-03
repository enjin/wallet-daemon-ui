import 'package:enjin_wallet_daemon/presentation/loading_screen/binding/loading_biding.dart';
import 'package:enjin_wallet_daemon/presentation/loading_screen/loading_screen.dart';
import 'package:enjin_wallet_daemon/presentation/onboard_screen/binding/onboard_biding.dart';
import 'package:enjin_wallet_daemon/presentation/onboard_screen/onboard_screen.dart';
import 'package:enjin_wallet_daemon/presentation/six_screen/binding/six_binding.dart';
import 'package:enjin_wallet_daemon/presentation/six_screen/six_screen.dart';
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
      page: () => SixScreen(),
      title: 'Main',
      binding: SixBinding(),
    ),
    // GetPage(
    //   name: Routes.onboard.nameToRoute(),
    //   page: () => const OnboardScreen(),
    //   title: 'Onboard',
    //   // binding: LoadingBinding(),
    // ),
  ];
}
