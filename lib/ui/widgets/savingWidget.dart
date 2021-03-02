import 'package:expanses/models/expensesModel.dart';
import 'package:expanses/models/savingsModel.dart';
import 'package:flutter/material.dart';

class SavingWidget extends StatefulWidget {
  Saving _saving;
  SavingWidget(this._saving);
  @override
  _SavingWidgetState createState() => _SavingWidgetState();
}

class _SavingWidgetState extends State<SavingWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: Text(widget._saving.value.toString()),
        title: Text(widget._saving.name),
        subtitle: Text(parseDate(widget._saving.date)),
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
