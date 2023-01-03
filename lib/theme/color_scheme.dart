import 'package:flutter/material.dart';
import 'package:quizz_app/theme/colors.dart';

class QuizzAppColorScheme {
  static const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: QuizzAppColors.starCommandBlue,
    onPrimary: Colors.white,
    secondary: QuizzAppColors.mikadoYellow,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: QuizzAppColors.midnightBlue,
    onBackground: Colors.white,
    surface: QuizzAppColors.midnightBlue,
    onSurface: Colors.white,
  );
}
