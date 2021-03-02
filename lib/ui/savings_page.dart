import 'package:expanses/providers/ExpensesProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'add_saving.dart';
import 'package:expanses/ui/widgets/savingWidget.dart';

class SavingsPage extends StatefulWidget {
  @override
  _SavingsPageState createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(builder: (context, value, child) {
      return Scaffold(
        body: Container(
          child: ListView.builder(
              itemCount: value.savings.length,
              itemBuilder: (BuildContext context, int index) {
                return SavingWidget(value.savings[index]);
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddSavingPage());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple[400],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
