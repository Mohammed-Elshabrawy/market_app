import 'package:flutter/material.dart';

void navigateToWithoutBack(BuildContext context,{required Widget screen}) {

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}