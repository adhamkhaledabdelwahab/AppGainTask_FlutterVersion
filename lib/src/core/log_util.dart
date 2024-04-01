import 'dart:developer';

import 'package:flutter/foundation.dart';

class LogUtil {
  static void d(String tag, String message) {
    if (kDebugMode) {
      log(message, name: tag);
    }
  }
}
