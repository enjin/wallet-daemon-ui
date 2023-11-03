import 'package:enjin_wallet_daemon/screens/loading/loading_biding.dart';
import 'package:enjin_wallet_daemon/screens/loading/loading_screen.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static String init = Routes.Home.nameToRoute();

  // LoadingScreen.id: (context) => const LoadingScreen(),
  // MainScreen.id: (context) => const MainScreen(),
  // LockScreen.id: (context) => const LockScreen(),
  // OnboardScreen.id: (context) => const OnboardScreen(),

  static final routes = [
    GetPage(
      name: Routes.Home.nameToRoute(),
      page: () => const LoadingScreen(),
      title: 'Loading',
      binding: LoadingBinding(),
    ),
    // GetPageExample.getPageExample,
    //GetPage(name: '/responsive',title: 'Get Responsive View', page: () => ResponsiveView()),
    // GetPage(
    //     name: '/counter',
    //     page: () => CounterView(),
    //     title: 'Counter App',
    //     binding: CounterBinding()),
    // GetPage(
    //     name: '/simple-navigation',
    //     title: 'Simple Navigation',
    //     page: () => SimpleNavigationView1(),
    //     binding: SimpleNavigationBinding1(),
    //     children: [
    //       GetPage(
    //           name: '/2',
    //           page: () => SimpleNavigationView2(),
    //           binding: SimpleNavigationBinding2())
    //     ])
  ];
}
