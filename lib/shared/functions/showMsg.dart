import 'package:flutter/material.dart';

import '../../modules/auth/logic/authentication_cubit.dart';

void showMsg(BuildContext context, {required String text}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(text), backgroundColor: Colors.red));
}
