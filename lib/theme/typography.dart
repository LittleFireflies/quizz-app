import 'package:flutter/material.dart';

class QuizzAppTypography {
  const QuizzAppTypography._();

  static const TextStyle appTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
}

extension QuizzAppTextThemeTextStyles on TextTheme {
  TextStyle get appTitle => QuizzAppTypography.appTitle;
}
