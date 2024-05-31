import 'package:card_tracker/notification_service.dart';
import 'package:flutter/material.dart';

import 'app/routes/routes.dart';

final notifService = NotificationService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notifService.init();

  runApp(const CardTracker());
}

class CardTracker extends StatelessWidget {
  const CardTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: onGenerateRoute,
      initialRoute: Routes.login,
    );
  }
}
