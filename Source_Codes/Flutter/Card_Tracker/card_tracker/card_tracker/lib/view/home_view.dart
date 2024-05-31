import 'package:card_tracker/data/data_source.dart';
import 'package:card_tracker/main.dart';
import 'package:card_tracker/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late User user;

  @override
  void initState() {
    if (DataSource.isAdmin) {
      user = DataSource.adminUser;
    } else {
      user = DataSource.newUser;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: user.beacons.isNotEmpty
          ? ListView.builder(
              itemCount: user.beacons.length,
              itemBuilder: (context, index) {
                final beacon = user.beacons[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            beacon.creditCard.cardName,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () async {
                              Future.delayed(const Duration(seconds: 10),
                                  () async {
                                notifService.flutterLocalNotificationsPlugin
                                    .show(
                                  12,
                                  beacon.creditCard.cardName,
                                  '${beacon.creditCard.cardName} is too far',
                                  const NotificationDetails(
                                    android: AndroidNotificationDetails(
                                      '123',
                                      'test',
                                      icon: 'app_icon',
                                    ),
                                  ),
                                );
                              });
                            },
                            icon: const Icon(Icons.message),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          children: [
                            Text(
                              beacon.creditCard.cardNumber,
                              style: const TextStyle(
                                  fontSize: 18, letterSpacing: 4),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  user = user.copyWith(
                                    beacons: user.beacons
                                        .where((element) =>
                                            element != user.beacons[index])
                                        .toList(),
                                  );
                                });
                              },
                              icon: const Icon(Icons.delete),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Beacon ID: ${beacon.beaconIdentifier}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text('No Cards Found'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/addBeacon');
          setState(() {
            if (DataSource.isAdmin) {
              user = DataSource.adminUser;
            } else {
              user = DataSource.newUser;
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
