import 'package:expanses/services/DBHelper.dart';

class Saving {
  int id;
  int walletID;
  String name;
  String date;
  String value;
  String note;
  Saving({this.name, this.date, this.value, this.walletID, this.note});

  Saving.fromMap(Map map) {
    this.id = map[DBHelper.savingID];

    this.name = map[DBHelper.savingName];
    this.date = map[DBHelper.savingDate];
    this.note = map[DBHelper.savingNote];

    this.value = map[DBHelper.savingValue];
    this.walletID = map[DBHelper.wallet_ID];
  }

  Map<String, dynamic> toMap() {
    return {
      DBHelper.savingName: this.name,
      DBHelper.savingDate: this.date,
      DBHelper.savingNote: this.note,
      DBHelper.savingValue: this.value,
      DBHelper.wallet_ID: this.walletID,
    };
  }
}
