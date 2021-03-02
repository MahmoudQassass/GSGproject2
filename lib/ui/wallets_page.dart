import 'package:expanses/providers/ExpensesProvider.dart';
import 'package:expanses/ui/widgets/walletWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/route_manager.dart';
import 'add_wallet_page.dart';

class WalletsPage extends StatefulWidget {
  @override
  _WalletsPageState createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(builder: (context, value, child) {
      return Scaffold(
        body: Container(
          child: ListView.builder(
              itemCount: value.wallets.length,
              itemBuilder: (BuildContext context, int index) {
                return WalletWidget(value.wallets[index]);
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddWalletPage());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple[400],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
