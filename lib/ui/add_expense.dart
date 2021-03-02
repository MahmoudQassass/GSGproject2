import 'package:expanses/models/expensesModel.dart';
import 'package:expanses/models/walletsModel.dart';
import 'package:expanses/providers/ExpensesProvider.dart';
import 'package:expanses/ui/widgets/customTextFormField.dart';
import 'package:expanses/ui/widgets/warningDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  String name;
  String value;
  String date;
  String note;
  final _formKey = GlobalKey<FormState>();

  saveExpenseName(String value) {
    this.name = value;
  }

  saveExpenseNote(String value) {
    this.note = value ?? '';
  }

  saveExpenseValue(String value) {
    this.value = value;
  }

  saveExpenseDate(String value) {
    this.date = value;
  }

  String validateExpenseName(String value) {
    if (value == null || value == '') {
      return 'هذا الحقل مطلوب';
    }
  }

  String validateExpenseNote(String value) {
    // without validateing
  }

  String validateExpenseValue(String value) {
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

        await context.read<ExpensesProvider>().insertNewExpense(Expense(
            name: this.name,
            date: this.date,
            value: this.value,
            note: this.note,
            walletID: activeWallet.id));

        var expenseValue = double.parse(this.value);
        var activeWalletValue = double.parse(activeWallet.value);
        var newActiveWalletValue = activeWalletValue - expenseValue;
        activeWallet.value = newActiveWalletValue.toString();

        await context.read<ExpensesProvider>().updateWalletValue(activeWallet);
        Navigator.pop(context);
      } else {
        WarningDialog().showWarningDialog(
            'قم بتفعيل أو إنشاء محفظة لتتم المعاملة', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          title: Center(
            child: Text('أنشئ محفظة'),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'إسم المعاملة',
                    textAlign: TextAlign.start,
                    saveFunction: saveExpenseName,
                    validateFun: validateExpenseName,
                    keyboardType: TextInputType.text,
                    hint: 'مثال (فاتورة كهرباء)',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    label: 'قيمة المعاملة',
                    textAlign: TextAlign.start,
                    saveFunction: saveExpenseValue,
                    validateFun: validateExpenseValue,
                    keyboardType: TextInputType.number,
                    hint: '0.00',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    label: 'ملاحظات',
                    textAlign: TextAlign.start,
                    saveFunction: saveExpenseNote,
                    validateFun: validateExpenseNote,
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
                      "أنشئ معاملة",
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
