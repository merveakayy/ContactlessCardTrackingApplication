class CreditCard {
  final String cardNumber;
  final String cardName;

  const CreditCard({
    required this.cardNumber,
    required this.cardName,
  });

  CreditCard copyWith({
    String? cardNumber,
    String? cardName,
  }) {
    return CreditCard(
      cardNumber: cardNumber ?? this.cardNumber,
      cardName: cardName ?? this.cardName,
    );
  }

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      cardNumber: json['cardNumber'],
      cardName: json['cardName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'cardName': cardName,
    };
  }
}
