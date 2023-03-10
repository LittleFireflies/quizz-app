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

  static final quizCardColorScheme = QuizzAppColorScheme.colorScheme.copyWith(
    brightness: Brightness.light,
    surface: Colors.white,
    onSurface: Colors.black,
    primary: Colors.white,
    onPrimary: Colors.black,
  );
}

extension QuizzAppColorSchemeExtension on ColorScheme {
  Color get green => Colors.green;
  Color get red => Colors.red;
}
