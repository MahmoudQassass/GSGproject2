import 'dart:async';
import 'package:provider/provider.dart';
import 'package:expanses/models/walletsModel.dart';
import 'package:expanses/providers/ExpensesProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'warningDialogWidget.dart';
import 'loadingWidget.dart';
import 'package:expanses/ui/wallet_details_page.dart';

class WalletWidget extends StatefulWidget {
  Wallet _wallet;
  WalletWidget(this._wallet);
  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Get.to(WalletDetailsPage(widget._wallet));
        },
        leading: Switch(
            value: widget._wallet.isActive,
            onChanged: (value) async {
              if (value == false) {
                var wallets = context.read<ExpensesProvider>().wallets;
                if (wallets.length != 1) {
                  print(wallets.length);
                  WarningDialog().showWarningDialog(
                      'قم بتفعيل أحد المحفظات الأخرى ليتم الغاء تفعيل هذه المحفظة',
                      context);
                } else {
                  WarningDialog().showWarningDialog(
                      'لا يمكن الغاء تفعيل المحفظة الوحيدة لديك, قم بإنشاء محفظة أخرى',
                      context);
                }
              } else {
                Get.to(LoadingWidget());
                await context
                    .read<ExpensesProvider>()
                    .updateWalletActiveState(widget._wallet);
              }
            }),
        trailing: Text(widget._wallet.value.toString()),
        title: Text(widget._wallet.name),
        subtitle: Text(parseDate(widget._wallet.date)),
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
