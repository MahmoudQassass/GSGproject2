import 'package:expanses/models/expensesModel.dart';
import 'package:flutter/material.dart';

class ExpenseWidget extends StatefulWidget {
  Expense _expense;
  ExpenseWidget(this._expense);
  @override
  _ExpenseWidgetState createState() => _ExpenseWidgetState();
}

class _ExpenseWidgetState extends State<ExpenseWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: Text(widget._expense.value.toString()),
        title: Text(widget._expense.name),
        subtitle: Text(parseDate(widget._expense.date)),
      ),
    );
  }

  parseDate(String date) {
    return DateTime.parse(date).year.toString() +
        '-' +
        DateTime.parse(date).month.toString() +
        '-' +
        DateTime.parse(date).day.toString();
  }
}
