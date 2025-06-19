import 'package:flutter/material.dart';

import '../styles/style.dart';
AppBar buildCustomAppBar(BuildContext context, {required String label}) {
  return AppBar(
    backgroundColor: AppColors.kPrimaryColor,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios, color: AppColors.kWhiteColor),
    ),
    title: Text(
      label,
      style: TextStyle(
        color: AppColors.kWhiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
  );
}
