class CreditCard {
  final int? id;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String cardHolder;

  CreditCard({
    this.id,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.cardHolder,
  });

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(
      id: map['id'],
      cardNumber: map['cardNumber'],
      expiryDate: map['expiryDate'],
      cvv: map['cvv'],
      cardHolder: map['cardHolder'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'cardHolder': cardHolder,
    };
  }
}