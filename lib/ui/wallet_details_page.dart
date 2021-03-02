import 'package:expanses/models/expensesModel.dart';
import 'package:expanses/models/savingsModel.dart';
import 'package:expanses/models/walletsModel.dart';
import 'package:expanses/providers/ExpensesProvider.dart';
import 'package:expanses/ui/widgets/expenseWidget.dart';
import 'package:expanses/ui/widgets/savingWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletDetailsPage extends StatefulWidget {
  Wallet wallet;
  WalletDetailsPage(this.wallet);
  @override
  _WalletDetailsPageState createState() => _WalletDetailsPageState();
}

class _WalletDetailsPageState extends State<WalletDetailsPage> {
  @override
  Widget build(BuildContext context) {
    List<Expense> expenses = context
        .read<ExpensesProvider>()
        .expenses
        .where((e) => e.walletID == widget.wallet.id)
        .toList();

    List<Saving> savings = context
        .read<ExpensesProvider>()
        .savings
        .where((e) => e.walletID == widget.wallet.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Center(child: Text('تفاصيل المحفظة')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text('معاملات المحفظة'),
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: expenses.map((e) => ExpenseWidget(e)).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Text('مدخرات المحفظة'),
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: savings.map((e) => SavingWidget(e)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
