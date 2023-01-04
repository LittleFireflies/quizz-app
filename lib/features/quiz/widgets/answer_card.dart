import 'package:flutter/material.dart';
import 'package:quizz_app/core/shared_widgets/quizz_primary_button.dart';
import 'package:quizz_app/core/shared_widgets/quizz_secondary_button.dart';
import 'package:quizz_app/theme/color_scheme.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    Key? key,
    required this.text,
    required this.correctAnswer,
    this.selected = false,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final bool selected;
  final String correctAnswer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return selected
        ? QuizzSecondaryButton(
            label: text,
            trailing: text == correctAnswer
                ? Icon(
                    Icons.check_circle_rounded,
                    color: Theme.of(context).colorScheme.green,
                  )
                : Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.red,
                  ),
            onPressed: onTap,
          )
        : QuizzPrimaryButton(label: text, onPressed: onTap);
  }
}
