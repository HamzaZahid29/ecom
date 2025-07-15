import 'package:flutter/material.dart';

import '../../globals.dart';

class AppSnackbarService {
  static void showSnackbar(String text) {
    snackbarKey.currentState
      ?..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}
