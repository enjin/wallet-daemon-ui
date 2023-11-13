part of 'app_pages.dart';

abstract class Routes {
  static const main = 'Main';
  static const loading = 'Loading';
  static const lock = 'Lock';
  static const onboard = 'Onboard';
}

extension RoutesExtension on String {
  String nameToRoute() => '/${toLowerCase()}';
}
