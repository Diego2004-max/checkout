class Order {
  final int? id;
  final double total;
  final String date;
  final int cardId;

  Order({
    this.id,
    required this.total,
    required this.date,
    required this.cardId,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      total: map['total'],
      date: map['date'],
      cardId: map['cardId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'total': total,
      'date': date,
      'cardId': cardId,
    };
  }
}