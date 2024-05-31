class Person {
  int? id;
  String nameSurname;
  String phoneNumber;
  String email;
  bool isFavorite;
  DateTime? lastNotificationTime;

  Person({
    this.id,
    required this.nameSurname,
    required this.phoneNumber,
    required this.email,
    this.isFavorite = false,
    this.lastNotificationTime,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      nameSurname: json['nameSurname'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      isFavorite: json['isFavorite'],
      lastNotificationTime: json['lastNotificationTime'] != null
          ? DateTime.parse(json['lastNotificationTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameSurname': nameSurname,
      'phoneNumber': phoneNumber,
      'email': email,
      'isFavorite': isFavorite,
      'lastNotificationTime': lastNotificationTime?.toIso8601String(),
    };
  }
}
