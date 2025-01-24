import 'package:flutter/material.dart';

class SnackBarService {

  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  // Mostrar snackbar con un mensaje
  void showSnackBar(String message) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  // (Opcional) mostrar snackbar con personalización adicional
  void showCustomSnackBar(String message, {Color? backgroundColor}) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      )
    );
  }

}