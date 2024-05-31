import 'package:card_tracker/data/data_source.dart';
import 'package:card_tracker/model/beacon.dart';
import 'package:card_tracker/model/credit_card.dart';
import 'package:flutter/material.dart';

class AddBeaconView extends StatefulWidget {
  const AddBeaconView({super.key});

  @override
  State<AddBeaconView> createState() => _AddBeaconViewState();
}

class _AddBeaconViewState extends State<AddBeaconView> {
  final TextEditingController _beaconIdentifier = TextEditingController();
  final TextEditingController _cardName = TextEditingController();
  final TextEditingController _cardNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Beacon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _beaconIdentifier,
              decoration: InputDecoration(labelText: 'Beacon Identifier'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _cardName,
              decoration: InputDecoration(labelText: 'Card Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _cardNo,
              decoration: InputDecoration(labelText: 'Card No'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (DataSource.isAdmin) {
                  DataSource.adminUser = DataSource.adminUser.copyWith(
                    beacons: [
                      ...DataSource.adminUser.beacons,
                      Beacon(
                        beaconIdentifier: _beaconIdentifier.text,
                        creditCard: CreditCard(
                          cardName: _cardName.text,
                          cardNumber: _cardNo.text,
                        ),
                      ),
                    ],
                  );

                  Navigator.pop(context);
                } else {
                  DataSource.newUser = DataSource.newUser.copyWith(
                    beacons: [
                      ...DataSource.newUser.beacons,
                      Beacon(
                        beaconIdentifier: _beaconIdentifier.text,
                        creditCard: CreditCard(
                          cardName: _cardName.text,
                          cardNumber: _cardNo.text,
                        ),
                      ),
                    ],
                  );
                  await DataSource.restService
                      .updateBeacons(DataSource.newUser);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
