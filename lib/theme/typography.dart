import 'package:flutter/material.dart';

class QuizzAppTypography {
  const QuizzAppTypography._();

  static const TextStyle appTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle quizTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle quizAnswer = TextStyle(
    fontSize: 14,
  );
}

extension QuizzAppTextThemeTextStyles on TextTheme {
  TextStyle get appTitle => QuizzAppTypography.appTitle;

  TextStyle get quizTitle => QuizzAppTypography.quizTitle;

  TextStyle get quizAnswer => QuizzAppTypography.quizAnswer;
}
