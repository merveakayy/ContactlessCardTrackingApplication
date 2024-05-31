import 'package:card_tracker/view/add_beacon_view.dart';
import 'package:card_tracker/view/home_view.dart';
import 'package:card_tracker/view/login_view.dart';
import 'package:flutter/material.dart';

Route? onGenerateRoute(RouteSettings settings) {
  if (settings.name != null) {
    final child = createView(settings.name!);

    if (child != null) {
      return MaterialPageRoute(
        builder: (_) => child,
        settings: settings,
      );
    }
    return null;
  } else {
    return null;
  }
}

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String addBeacon = '/addBeacon';
}

Widget? createView(String route) {
  switch (route) {
    case Routes.login:
      return const LoginView();
    case Routes.home:
      return const HomeView();
    case Routes.addBeacon:
      return const AddBeaconView();

    default:
      return null;
  }
}
