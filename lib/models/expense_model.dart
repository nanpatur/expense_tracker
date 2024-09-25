
class ExpenseModel {
  int? id;
  int? amount;
  String? description;
  String? category;
  DateTime? date;

  ExpenseModel({
    this.id,
    this.amount,
    this.description,
    this.category,
    this.date,
  });

  factory ExpenseModel.fromJSON(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      amount: json['amount'],
      description: json['description'],
      category: json['category'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date!.toIso8601String(),
    };
  }
}

enum ExpenseCategory {
  food,
  transport,
  entertainment,
  health,
  education,
  other,
}
