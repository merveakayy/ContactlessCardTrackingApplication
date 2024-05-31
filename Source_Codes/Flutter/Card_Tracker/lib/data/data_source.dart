import 'package:card_tracker/data/rest_service.dart';
import 'package:card_tracker/model/beacon.dart';
import 'package:card_tracker/model/credit_card.dart';
import 'package:card_tracker/model/user.dart';
import 'package:dio/dio.dart';

class DataSource {
  static final restService = RestService(Dio());

  static bool isAdmin = false;

  static User adminUser = const User(
    username: 'Admin',
    beacons: [
      Beacon(
        beaconIdentifier: '1234567890',
        creditCard: CreditCard(
          cardNumber: '1234 5678 9012 3456',
          cardName: 'Test card 1',
        ),
      ),
      Beacon(
        beaconIdentifier: '0987654321',
        creditCard: CreditCard(
          cardNumber: '6543 2109 8765 4321',
          cardName: 'Test card 2',
        ),
      ),
    ],
  );

  static User newUser = const User(
    username: 'New User',
    beacons: [],
  );
}
