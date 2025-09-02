import 'package:flutter/material.dart';

class AppGradients {
  static LinearGradient get lightGradient => const LinearGradient(
        colors: [Color(0xFFE1F5FE), Color(0xFFB2EBF2), Color(0xFFB39DDB)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  static LinearGradient get darkGradient => const LinearGradient(
        colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}