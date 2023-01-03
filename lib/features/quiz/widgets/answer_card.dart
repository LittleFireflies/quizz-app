import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/shared_widgets/quizz_primary_button.dart';
import 'package:quizz_app/core/shared_widgets/quizz_secondary_button.dart';
import 'package:quizz_app/features/quiz/bloc/quiz_bloc.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    Key? key,
    required this.text,
    this.selected = false,
  }) : super(key: key);

  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return selected
        ? QuizzSecondaryButton(
            label: text,
            onPressed: () {
              context.read<QuizBloc>().add(SelectAnswer(text));
            },
          )
        : QuizzPrimaryButton(
            label: text,
            onPressed: () {
              context.read<QuizBloc>().add(SelectAnswer(text));
            },
          );
  }
}
