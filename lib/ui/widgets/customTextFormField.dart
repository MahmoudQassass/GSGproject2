import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextFormField extends StatelessWidget {
  Function validateFun;
  Function saveFunction;
  String label;
  Icon icon;
  String hint;
  String initValue;
  TextAlign textAlign = TextAlign.start;
  TextInputType keyboardType;
  CustomTextFormField(
      {this.label,
      this.textAlign,
      this.initValue,
      @required this.saveFunction,
      @required this.validateFun,
      this.hint,
      this.icon,
      this.keyboardType});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      initialValue: this.initValue ?? '',
      textAlign: this.textAlign,
      validator: (newValue) => validateFun(newValue),
      onSaved: (newValue) => saveFunction(newValue),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.deepPurple[400],
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: hint,
        labelText: label,
        prefixIcon: icon,
      ),
    );
  }
}
