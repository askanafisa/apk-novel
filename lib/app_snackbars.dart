import 'package:flutter/material.dart';
import 'main.dart'; // supaya bisa pakai messengerKey

class AppSnackbars {
  static void show(String message, {IconData icon = Icons.check_circle}) {
    final ctx = messengerKey.currentContext;
    if (ctx == null) return;

    final isDark = Theme.of(ctx).brightness == Brightness.dark;

    final snack = SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white, // ikon tetap putih biar kontras
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: isDark ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 255, 255, 255), // teks adaptif
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    messengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snack);
  }
}
