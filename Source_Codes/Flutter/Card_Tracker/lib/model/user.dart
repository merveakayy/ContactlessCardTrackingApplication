import 'package:card_tracker/model/beacon.dart';

class User {
  final String username;
  final List<Beacon> beacons;
  final String? mobilePushAddress;

  const User({
    required this.username,
    required this.beacons,
    this.mobilePushAddress,
  });

  User copyWith({
    String? username,
    List<Beacon>? beacons,
    String? mobilePushAddress,
  }) {
    return User(
      username: username ?? this.username,
      beacons: beacons ?? this.beacons,
      mobilePushAddress: mobilePushAddress ?? this.mobilePushAddress,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      beacons:
          List<Beacon>.from(json['beacons']?.map((x) => Beacon.fromJson(x))),
      mobilePushAddress: json['mobilePushAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'beacons': beacons.map((x) => x.toJson()).toList(),
      'mobilePushAddress': mobilePushAddress,
    };
  }
}
