import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'isIOS.dart';

void navigateTo(context, widget) => !isIOS()
    ? Navigator.push(context, MaterialPageRoute(builder: (context) => widget))
    : Navigator.push(context, CupertinoPageRoute(builder: (context) => widget));
