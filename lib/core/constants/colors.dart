import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00627f);
  static const Color secondary = Color(0xFFfc8930);
  static const Color blackSoft = Color(0xFF121212);
  static const Color blackDark = Color(0xFF1E1E1E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greyLight = Color(0xFFEEEEEE);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyDark = Color(0xFF424242);

  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00627f), Color(0xFF0094a8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFfc8930), Color(0xFFfca24d)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient blackWhiteGradient = LinearGradient(
    colors: [blackSoft, greyDark, grey, white],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}