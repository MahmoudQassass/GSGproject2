import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  showWarningDialog(String content, BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(content),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ok'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
