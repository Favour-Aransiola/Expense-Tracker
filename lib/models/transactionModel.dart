// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionModel {
  int id;
  String title;
  double amount;
  DateTime date;
  TransactionModel(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.amount == amount &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ amount.hashCode ^ date.hashCode;
  }
}
