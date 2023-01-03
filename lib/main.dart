import 'package:flutter/material.dart';
import 'package:quizz_app/features/home/view/home_page.dart';
import 'package:quizz_app/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: QuizzAppTheme.mainTheme(),
      home: const HomePage(),
    );
  }
}
