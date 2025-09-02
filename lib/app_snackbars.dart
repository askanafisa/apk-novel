import 'package:flutter/material.dart';
import 'main.dart'; // supaya bisa pakai messengerKey

class AppSnackbars {
  static void show(String message, {IconData icon = Icons.check_circle}) {
    final ctx = messengerKey.currentContext;
    if (ctx == null) return;

    final snack = SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
    );

    messengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snack);
  }
}
