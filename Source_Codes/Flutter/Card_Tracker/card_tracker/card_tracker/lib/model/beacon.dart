import 'package:card_tracker/model/credit_card.dart';

class Beacon {
  final String beaconIdentifier;
  final CreditCard creditCard;

  const Beacon({
    required this.beaconIdentifier,
    required this.creditCard,
  });

  Beacon copyWith({
    String? beaconIdentifier,
    CreditCard? creditCard,
  }) {
    return Beacon(
      beaconIdentifier: beaconIdentifier ?? this.beaconIdentifier,
      creditCard: creditCard ?? this.creditCard,
    );
  }

  factory Beacon.fromJson(Map<String, dynamic> json) {
    return Beacon(
      beaconIdentifier: json['beaconIdentifier'],
      creditCard: CreditCard.fromJson(json['creditCard']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'beaconIdentifier': beaconIdentifier,
      'creditCard': creditCard.toJson(),
    };
  }
}
