import 'package:expanses/providers/ExpensesProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'add_expense.dart';
import 'package:expanses/ui/widgets/expenseWidget.dart';

class ExpensesPage extends StatefulWidget {
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(builder: (context, value, child) {
      return Scaffold(
        body: Container(
          child: ListView.builder(
              itemCount: value.expenses.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpenseWidget(value.expenses[index]);
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddExpensePage());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple[400],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
