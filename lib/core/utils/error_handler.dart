import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

void showError(BuildContext context, String message) {
  Flushbar(
    message: message,
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
  ).show(context);
}
