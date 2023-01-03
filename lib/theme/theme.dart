import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/theme/color_scheme.dart';

class QuizzAppTheme {
  static ThemeData mainTheme() {
    return applyAllStyles(
      ThemeData.from(colorScheme: QuizzAppColorScheme.colorScheme),
    );
  }

  static ThemeData applyAllStyles(
    ThemeData themeData,
  ) {
    return themeData.copyWith(
      textTheme: GoogleFonts.interTextTheme(themeData.textTheme),
    );
  }

  static ThemeData createQuizCardTheme() {
    return applyAllStyles(
      ThemeData.from(colorScheme: QuizzAppColorScheme.quizCardColorScheme),
    );
  }
}
