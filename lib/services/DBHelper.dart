import 'dart:io';
import 'package:expanses/models/expensesModel.dart';
import 'package:expanses/models/savingsModel.dart';
import 'package:expanses/models/walletsModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();

  /// Wallets
  static final String walletTableName = 'wallets';
  static final String walletID = 'id';
  static final String walletName = 'name';
  static final String walletDate = 'date';
  static final String walletValue = 'value';
  static final String walletIsActive = 'isActive';

  /// Expenses
  static final String expenseTableName = 'expenses';
  static final String expenseID = 'id';
  static final String wallet_ID = 'wallet_id';
  static final String expenseName = 'name';
  static final String expenseDate = 'date';
  static final String expenseNote = 'note';
  static final String expenseValue = 'value';

  /// Savings
  static final String savingTableName = 'savings';
  static final String savingID = 'id';
  static final String savingName = 'name';
  static final String savingDate = 'date';
  static final String savingNote = 'note';
  static final String savingValue = 'value';
  Database database;
  initDatabase() async {
    if (database == null) {
      database = await connectToDataBase();
    }
  }

  Future<Database> connectToDataBase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String appDocPath = appDirectory.path;
    String databasePath = join(appDocPath, 'expensesDB.db');
    Database database =
        await openDatabase(databasePath, version: 1, onCreate: (db, version) {
      walletTable(db);
      expensesTable(db);
      savingsTable(db);
    });
    return database;
  }

  walletTable(Database database) async {
    await database.execute('''CREATE TABLE $walletTableName (
      $walletID INTEGER PRIMARY KEY AUTOINCREMENT,
      $walletName TEXT NOT NULL,
      $walletDate TEXT NOT NULL,
      $walletValue TEXT NOT NULL,
      $walletIsActive INTEGER NOT NULL
      )''');
  }

  expensesTable(Database database) async {
    await database.execute('''CREATE TABLE $expenseTableName (
      $expenseID INTEGER PRIMARY KEY AUTOINCREMENT,
      $wallet_ID INTEGER,
      $expenseName TEXT NOT NULL,
      $expenseNote TEXT,
      $expenseDate TEXT NOT NULL,
      $expenseValue TEXT NOT NULL
      )''');
  }

  savingsTable(Database database) async {
    await database.execute('''CREATE TABLE $savingTableName (
      $savingID INTEGER PRIMARY KEY AUTOINCREMENT,
      $wallet_ID INTEGER,
      $savingName TEXT NOT NULL,
      $savingNote TEXT,
      $savingDate TEXT NOT NULL,
      $savingValue TEXT NOT NULL
      )''');
  }
/////// wallets actions

  insertNewWallet(Wallet wallet) async {
    try {
      int walletID = await database.insert(walletTableName, wallet.toMap());
      return walletID;
    } on Exception catch (e) {
      print(e);
    }
  }

  updateWallet(Wallet wallet) async {
    try {
      await database.update(walletTableName, wallet.toMap(),
          where: '$walletID=?', whereArgs: [wallet.id]);
    } catch (e) {}
  }

  getActiveWallet() async {
    try {
      List<Map<String, dynamic>> result = await database.query(walletTableName,
          where: '$walletIsActive=?', whereArgs: [1], limit: 1);
      return result.first;
    } on Exception catch (e) {}
  }

  atciveWallet(Wallet wallet) async {
    try {
      await database.update(walletTableName, wallet.toMap(),
          where: '$walletID=?', whereArgs: [wallet.id]);
    } catch (e) {}
  }

  Future<List<Map<String, dynamic>>> getAllWallets() async {
    try {
      List<Map<String, dynamic>> allWallets =
          await database.query(walletTableName);
      return allWallets;
    } on Exception catch (e) {
      print(e);
    }
  }

////// expenses actions

  insertNewExpense(Expense expense) async {
    try {
      int expenseID = await database.insert(expenseTableName, expense.toMap());
      return expenseID;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getAllExpenses() async {
    try {
      List<Map<String, dynamic>> allExpenses =
          await database.query(expenseTableName);
      return allExpenses;
    } on Exception catch (e) {
      print(e);
    }
  }
////// savings actions

  insertNewSaving(Saving saving) async {
    try {
      int savingID = await database.insert(savingTableName, saving.toMap());
      return savingID;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getAllSavings() async {
    try {
      List<Map<String, dynamic>> allSavings =
          await database.query(savingTableName);
      return allSavings;
    } on Exception catch (e) {
      print(e);
    }
  }
}
