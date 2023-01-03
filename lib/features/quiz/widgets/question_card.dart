import 'package:flutter/material.dart';
import 'package:quizz_app/services/firestore/models/question.dart';
import 'package:quizz_app/theme/typography.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.question,
              style: Theme.of(context).textTheme.quizTitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
