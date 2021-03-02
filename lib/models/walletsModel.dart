import 'package:expanses/services/DBHelper.dart';

class Wallet {
  int id;
  String name;
  String date;
  String value;
  bool isActive;
  Wallet({this.name, this.date, this.value, this.isActive});

  Wallet.fromMap(Map map) {
    this.id = map[DBHelper.walletID];

    this.name = map[DBHelper.walletName];
    this.date = map[DBHelper.walletDate];

    this.value = map[DBHelper.walletValue];

    if (map[DBHelper.walletIsActive] == 1) {
      this.isActive = true;
    } else {
      this.isActive = false;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      DBHelper.walletName: this.name,
      DBHelper.walletDate: this.date,
      DBHelper.walletValue: this.value,
      DBHelper.walletIsActive: this.isActive ? 1 : 0,
    };
  }
}
