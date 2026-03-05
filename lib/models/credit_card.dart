class CreditCard {
  final int? id;
  final String cardNumber;
  final String holder;
  final String expiry;
  final String cvv;

  CreditCard({
    this.id,
    required this.cardNumber,
    required this.holder,
    required this.expiry,
    required this.cvv,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'holder': holder,
      'expiry': expiry,
      'cvv': cvv,
    };
  }

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(
      id: map['id'],
      cardNumber: map['cardNumber'],
      holder: map['holder'],
      expiry: map['expiry'],
      cvv: map['cvv'],
    );
  }
}