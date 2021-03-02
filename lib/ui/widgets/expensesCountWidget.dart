import 'package:flutter/material.dart';

class ExpensesCountWidget extends StatelessWidget {
  String title;
  String value;
  ExpensesCountWidget({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Text(this.title),
            Text(this.value),
          ],
        ),
      ),
    );
  }
}
