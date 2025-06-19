import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  CustomTextFormFiled({
    super.key,
    this.onTab,
    this.onSubmit,
    this.onChange,
    required this.controller,
    this.type,
    required this.validate,
    required this.label,
    this.prefix,
    this.border,
    this.suffix,
    this.obSecureText,
  });
  final bool readOnly = false;
  final Function()? onTab;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final TextEditingController controller;
  final TextInputType? type;
  final FormFieldValidator<String> validate;
  final String label;
  final IconData? prefix;
  final bool? obSecureText;
  final border;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obSecureText ?? false,
      readOnly: readOnly,
      onTap: onTab,
      controller: controller,
      keyboardType: type ?? TextInputType.text,
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
