import 'package:expanses/models/expensesModel.dart';
import 'package:flutter/material.dart';

class ExpensesByDatesWidget extends StatelessWidget {
  Expense _expense;
  ExpensesByDatesWidget(this._expense);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(this._expense.name),
      trailing: Text(this._expense.value),
    );
  }
}
