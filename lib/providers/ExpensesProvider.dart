import 'package:expanses/models/expensesModel.dart';
import 'package:expanses/models/savingsModel.dart';
import 'package:expanses/models/walletsModel.dart';
import 'package:expanses/services/DBHelper.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier {
  List<Wallet> wallets = [];
  List<Expense> expenses = [];
  List<Saving> savings = [];

///////////////////////////////////////  wallet part
  getAllWallets() async {
    List<Map<String, dynamic>> rows = await DBHelper.dbHelper.getAllWallets();
    List<Wallet> wallets =
        rows != null ? rows.map((e) => Wallet.fromMap(e)).toList() : [];

    setWallets(wallets);
  }

  setWallets(List<Wallet> wallets) {
    this.wallets = new List.from(wallets.reversed);
    notifyListeners();
  }

  insertNewWallet(Wallet wallet) async {
    int walletID;
    if (wallet.isActive == true) {
      for (var item in wallets) {
        item.isActive = false;
        await DBHelper.dbHelper.updateWallet(item);
      }
      walletID = await DBHelper.dbHelper.insertNewWallet(wallet);
    } else {
      walletID = await DBHelper.dbHelper.insertNewWallet(wallet);
    }
    getAllWallets();
    return walletID;
  }

  updateWalletActiveState(Wallet wallet) async {
    if (wallet.isActive == true) {
      wallet.isActive = false;

      await DBHelper.dbHelper.updateWallet(wallet);
    } else {
      for (var item in wallets) {
        item.isActive = false;
        await DBHelper.dbHelper.updateWallet(item);
      }
      wallet.isActive = true;
      await DBHelper.dbHelper.updateWallet(wallet);
    }
    getAllWallets();
  }

  updateWalletValue(Wallet wallet) async {
    await DBHelper.dbHelper.updateWallet(wallet);
    getAllWallets();
  }

////////////////////////////////////// expenses part
  getAllExpenses() async {
    List<Map<String, dynamic>> rows = await DBHelper.dbHelper.getAllExpenses();
    List<Expense> expenses =
        rows != null ? rows.map((e) => Expense.fromMap(e)).toList() : [];

    setExpenses(expenses);
  }

  setExpenses(List<Expense> expenses) {
    this.expenses = new List.from(expenses.reversed);
    notifyListeners();
  }

  insertNewExpense(Expense expense) async {
    int expenseID;
    expenseID = await DBHelper.dbHelper.insertNewExpense(expense);

    getAllExpenses();
    return expenseID;
  }

//////////////////////////////////// savings part
  getAllSavings() async {
    List<Map<String, dynamic>> rows = await DBHelper.dbHelper.getAllSavings();
    List<Saving> savings =
        rows != null ? rows.map((e) => Saving.fromMap(e)).toList() : [];

    setSavings(savings);
  }

  setSavings(List<Saving> savings) {
    this.savings = new List.from(savings.reversed);
    notifyListeners();
  }

  insertNewSavings(Saving saving) async {
    int savingID;
    savingID = await DBHelper.dbHelper.insertNewSaving(saving);

    getAllSavings();
    return savingID;
  }
}
