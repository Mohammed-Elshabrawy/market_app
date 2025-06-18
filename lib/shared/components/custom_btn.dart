import 'package:flutter/material.dart';

import '../styles/style.dart';



Widget defaultButton({required String text, required Function() onPressed}) =>
    OutlinedButton(
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

