import 'package:expanses/models/savingsModel.dart';
import 'package:expanses/models/walletsModel.dart';
import 'package:expanses/providers/ExpensesProvider.dart';
import 'package:expanses/ui/widgets/customTextFormField.dart';
import 'package:expanses/ui/widgets/warningDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';

class AddSavingPage extends StatefulWidget {
  @override
  _AddSavingPageState createState() => _AddSavingPageState();
}

class _AddSavingPageState extends State<AddSavingPage> {
  String name;
  String value;
  String date;
  String note;
  final _formKey = GlobalKey<FormState>();

  saveSavingName(String value) {
    if (value.isEmpty || value == null) {
      this.name = 'إدخار محول';
    } else {
      this.name = value;
    }
  }

  saveSavingNote(String value) {
    if (value.isEmpty || value == null) {
      this.note = 'بدون ملاحظات';
    } else {
      this.note = value;
    }
  }

  saveSavingValue(String value) {
    this.value = value;
  }

  saveSavingDate(String value) {
    this.date = value;
  }

  String validateSavingName(String value) {}

  String validateSavingNote(String value) {}

  String validateSavingValue(String value) {
    if (value == null || value == '') {
      return 'هذا الحقل مطلوب';
    } else if (value.length > 15) {
      return 'قم بإضافة قيمة صالحة';
    }
  }

  saveForm() async {
    bool validateResult = _formKey.currentState.validate();
    if (validateResult) {
      _formKey.currentState.save();
      Wallet activeWallet;
      if (context.read<ExpensesProvider>().wallets.length > 0) {
        activeWallet = context
            .read<ExpensesProvider>()
            .wallets
            .firstWhere((element) => element.isActive);
        //    if (double.parse(activeWallet.value) > 0) {
        await context.read<ExpensesProvider>().insertNewSavings(Saving(
            name: this.name ?? 'إدخار محول',
            date: this.date,
            value: this.value,
            note: this.note ?? 'بدون ملاحظات',
            walletID: activeWallet.id));

        var expenseValue = double.parse(this.value);
        var activeWalletValue = double.parse(activeWallet.value);
        var newActiveWalletValue = activeWalletValue - expenseValue;
        activeWallet.value = newActiveWalletValue.toString();

        await context.read<ExpensesProvider>().updateWalletValue(activeWallet);
        Navigator.pop(context);
        // } else {
        //   var activeWalletValue = double.parse(activeWallet.value);
        //   WarningDialog().showWarningDialog(
        //       'قيمة المحفظة $activeWalletValue سالبة', context);
        // }
      } else {
        WarningDialog().showWarningDialog(
            'كي تقوم بالإدخار, قم بتفعل أو إنشاء محفظة.', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          title: Center(
            child: Text('أنشئ إدخار'),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'حول الإدخار',
                    textAlign: TextAlign.start,
                    saveFunction: saveSavingName,
                    validateFun: validateSavingName,
                    keyboardType: TextInputType.text,
                    hint: 'غير مطلوب',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    label: 'قيمة الإدخار',
                    textAlign: TextAlign.start,
                    saveFunction: saveSavingValue,
                    validateFun: validateSavingValue,
                    keyboardType: TextInputType.number,
                    hint: '0.00',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    label: 'ملاحظات',
                    textAlign: TextAlign.start,
                    saveFunction: saveSavingNote,
                    validateFun: validateSavingNote,
                    keyboardType: TextInputType.text,
                    hint: 'غير مطلوب',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DateTimeFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    mode: DateTimeFieldPickerMode.dateAndTime,
                    autovalidateMode: AutovalidateMode.always,
                    onDateSelected: (value) {
                      this.date = value.toString();
                    },
                    onSaved: (value) {
                      this.date = value.toString();
                    },
                    lastDate: DateTime.now(),
                    initialValue: DateTime.now(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    color: Colors.deepPurple[400],
                    onPressed: () => saveForm(),
                    child: new Text(
                      "أنشئ إدخار",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
