import 'package:flutter/material.dart';

import '../styles/style.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key, this.onPressed, required this.text});

  final Function()? onPressed;

  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.kPrimaryColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
