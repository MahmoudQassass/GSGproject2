import 'package:expanses/services/DBHelper.dart';

class Expense {
  int id;
  int walletID;
  String name;
  String date;
  String value;
  String note;
  Expense({this.name, this.date, this.value, this.walletID, this.note});

  Expense.fromMap(Map map) {
    this.id = map[DBHelper.expenseID];

    this.name = map[DBHelper.expenseName];
    this.date = map[DBHelper.expenseDate];
    this.note = map[DBHelper.expenseNote];

    this.value = map[DBHelper.expenseValue];
    this.walletID = map[DBHelper.wallet_ID];
  }

  Map<String, dynamic> toMap() {
    return {
      DBHelper.expenseName: this.name,
      DBHelper.expenseDate: this.date,
      DBHelper.expenseNote: this.note,
      DBHelper.expenseValue: this.value,
      DBHelper.wallet_ID: this.walletID,
    };
  }
}
