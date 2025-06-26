import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../functions/isIOS.dart';
import '../styles/style.dart';

class CustomCircularIndicator extends StatelessWidget {
  const CustomCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    if (isIOS()) {
      return Center(
        child: CupertinoActivityIndicator(color: AppColors.kPrimaryColor),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(color: AppColors.kPrimaryColor),
      );
    }
  }
}
