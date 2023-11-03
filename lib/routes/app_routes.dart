part of 'app_pages.dart';

abstract class Routes {
  static const Main = 'Main';
  static const Loading = 'Loading';
  static const Lock = 'Lock';
  static const Onboard = 'Onboard';
}

extension RoutesExtension on String {
  String nameToRoute() => '/${toLowerCase()}';
}
