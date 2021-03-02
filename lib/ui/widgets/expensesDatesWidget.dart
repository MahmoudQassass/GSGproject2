import 'package:expanses/models/expensesModel.dart';
import 'package:expanses/providers/ExpensesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expanses/ui/widgets/expensesByDatesWidget.dart';

class ExpensesDate extends StatefulWidget {
  String date;
  ExpensesDate(this.date);

  @override
  _ExpensesDateState createState() => _ExpensesDateState();
}

class _ExpensesDateState extends State<ExpensesDate> {
  @override
  Widget build(BuildContext context) {
    List<Expense> expenses = context
        .read<ExpensesProvider>()
        .expenses
        .where((e) => parseDate(e.date) == widget.date)
        .toList();
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: Text(widget.date),
            trailing: Text(getExpensesTotalByDate().toString()),
          ),
        ),
        Column(
          children: expenses.map((e) => ExpensesByDatesWidget(e)).toList(),
        ),
      ],
    );
  }

  getExpensesTotalByDate() {
    double total = 0;
    List<Expense> expenses = context
        .read<ExpensesProvider>()
        .expenses
        .where((e) => parseDate(e.date) == this.widget.date)
        .toList();
    for (var item in expenses) {
      total += double.parse(item.value);
    }
    return total;
  }
}

parseDate(String date) {
  return DateTime.parse(date).year.toString() +
      '-' +
      DateTime.parse(date).month.toString() +
      '-' +
      DateTime.parse(date).day.toString();
}
