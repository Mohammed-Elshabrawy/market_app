import 'package:flutter/foundation.dart';

bool isIOS() {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return true;
  } else {
    return false;
  }
}
