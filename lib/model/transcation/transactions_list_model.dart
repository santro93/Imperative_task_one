class TransactionsListModel {
  final int? id;
  final String? date;
  final double? amount;
  final String? category;
  final String? description;

  TransactionsListModel({
    this.id,
    this.date,
    this.amount,
    this.category,
    this.description,
  });

  factory TransactionsListModel.fromJson(Map<String, dynamic> json) {
    return TransactionsListModel(
      id: json['id'] as int?,
      date: json['date'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      category: json['category'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'category': category,
      'description': description,
    };
  }
}
