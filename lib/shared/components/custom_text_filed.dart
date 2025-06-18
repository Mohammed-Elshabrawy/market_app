import 'package:flutter/material.dart';

class DefaultFormFiled extends StatelessWidget {
   DefaultFormFiled({
    super.key,
    this.onTab,
    this.onSubmit,
    this.onChange,
    required this.controller,
    required this.type,
    required this.validate,
    required this.label,
    this.prefix,
    this.border,
    this.suffix,
     required this.obSecureText,
  });
  final bool readOnly = false;
  final Function()? onTab;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final borderRadius = 16.0;
  final TextEditingController controller;
  final TextInputType type;
  final FormFieldValidator<String> validate;
  final String label;
  final prefix;
   bool obSecureText = false;
  final border;
  final suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
  }
}
