import 'package:expanses/models/walletsModel.dart';
import 'package:expanses/providers/ExpensesProvider.dart';
import 'package:expanses/ui/widgets/customTextFormField.dart';
import 'package:expanses/ui/widgets/warningDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';

class AddWalletPage extends StatefulWidget {
  @override
  _AddWalletPageState createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  String name;
  String value;
  String date;
  bool isActive = false;
  final _formKey = GlobalKey<FormState>();

  saveWalletName(String value) {
    this.name = value;
  }

  saveWalletValue(String value) {
    this.value = value;
  }

  saveWalletDate(String value) {
    this.date = value;
  }

  String validateWalletName(String value) {
    if (value == null || value == '') {
      return 'هذا الحقل مطلوب';
    } else if (value.length > 30) {
      return 'إسم المحفظة يجب أن يكون أقل من 30 حرفا';
    }
  }

  String validateWalletValue(String value) {
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
      }

      if (this.isActive == true) {
        await context.read<ExpensesProvider>().insertNewWallet(Wallet(
            name: this.name,
            date: this.date,
            value: this.value,
            isActive: this.isActive));
        Navigator.pop(context);
      } else {
        if (activeWallet != null) {
          await context.read<ExpensesProvider>().insertNewWallet(Wallet(
              name: this.name,
              date: this.date,
              value: this.value,
              isActive: this.isActive));
          Navigator.pop(context);
        } else {
          WarningDialog()
              .showWarningDialog('يجب عليك تفعيل أول محفظة لك', context);
        }
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
                    label: 'إسم المحفظة',
                    textAlign: TextAlign.start,
                    saveFunction: saveWalletName,
                    validateFun: validateWalletName,
                    keyboardType: TextInputType.text,
                    hint: 'مثال (راتب شهري)',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    label: 'قيمة المحفظة',
                    textAlign: TextAlign.start,
                    saveFunction: saveWalletValue,
                    validateFun: validateWalletValue,
                    keyboardType: TextInputType.number,
                    hint: '0.00',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DateTimeFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.event_note),
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
                  Row(
                    children: [
                      Switch(
                        activeColor: Colors.green,
                        value: isActive,
                        onChanged: (value) {
                          this.isActive = value;
                          setState(() {});
                        },
                      ),
                      Text('تفعيل المحفظة')
                    ],
                  ),
                  RaisedButton(
                    onPressed: () => saveForm(),
                    child: new Text(
                      "أنشئ محفظة",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.deepPurple[400],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
