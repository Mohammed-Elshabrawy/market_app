import 'package:flutter/material.dart';
Widget defaultFormFiled({
  bool readOnly = false,
  onTab,
  onSubmit,
  onChange,
  borderRadius = 16.0,
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
  obSecureText = false,
  border,
  suffix,
}) => TextFormField(
  obscureText: obSecureText,
  readOnly: readOnly,
  onTap: onTab,
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    suffixIcon: suffix, // Icon
    prefixIcon: Icon(prefix), // Icon
    focusedBorder: border,
    enabledBorder: border,
    border: border,
  ), // InputDecoration
);