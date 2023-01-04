import 'package:flutter/material.dart';
import 'package:quizz_app/features/quiz/models/answer_history.dart';
import 'package:quizz_app/theme/color_scheme.dart';
import 'package:quizz_app/theme/typography.dart';

class AnswerHistoryView extends StatelessWidget {
  const AnswerHistoryView({
    Key? key,
    required this.answer,
  }) : super(key: key);

  final AnswerHistory answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            answer.question,
            style: Theme.of(context).textTheme.quizAnswer,
          ),
          Row(
            children: [
              if (answer.answer != answer.correctAnswer) ...[
                Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.red,
                ),
                Text(answer.answer == '' ? 'No Answer' : answer.answer),
                const SizedBox(width: 8),
              ],
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.green,
              ),
              Text(answer.correctAnswer),
            ],
          ),
        ],
      ),
    );
  }
}
