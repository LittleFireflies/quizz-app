import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/shared_widgets/quizz_primary_button.dart';
import 'package:quizz_app/features/quiz/bloc/quiz_bloc.dart';
import 'package:quizz_app/features/quiz/widgets/answer_card.dart';
import 'package:quizz_app/features/quiz/widgets/question_card.dart';
import 'package:quizz_app/features/quiz/widgets/quiz_timer.dart';
import 'package:quizz_app/features/quiz_result/view/quiz_result_page.dart';
import 'package:quizz_app/services/firestore/models/question.dart';
import 'package:quizz_app/theme/theme.dart';

class QuizLoadedView extends StatelessWidget {
  final List<Question> questions;

  const QuizLoadedView({
    Key? key,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
      listenWhen: (p, c) => c.isFinished,
      listener: (context, state) {
        if (state.isFinished) {
          Navigator.pushReplacementNamed(
            context,
            QuizResultPage.routeName,
            arguments: state.quizResult,
          );
        }
      },
      builder: (context, state) {
        final activeQuestion = state.questions[state.activeQuestionIndex];

        return SafeArea(
          child: Theme(
            data: QuizzAppTheme.createQuizCardTheme(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                QuizTimer(
                  onTimesUp: () => !state.isLastQuestion
                      ? context.read<QuizBloc>().add(const OpenNextQuestion())
                      : context.read<QuizBloc>().add(const SeeResults()),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      QuestionCard(question: activeQuestion),
                      const SizedBox(height: 16),
                      ..._buildAnswerItems(state, context),
                    ],
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: state.selectedAnswer != '',
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: QuizzPrimaryButton(
                      label: !state.isLastQuestion
                          ? 'Next Question'
                          : 'See Results',
                      onPressed: () => !state.isLastQuestion
                          ? context
                              .read<QuizBloc>()
                              .add(const OpenNextQuestion())
                          : context.read<QuizBloc>().add(const SeeResults()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildAnswerItems(
    QuizState state,
    BuildContext context,
  ) {
    final answerOptions = state.answerOptions;
    return answerOptions
        .map((option) => AnswerCard(
              text: option.answer,
              correctAnswer: option.isCorrectAnswer,
              selected: option.answer == state.selectedAnswer,
              onTap: () {
                if (state.selectedAnswer.isEmpty) {
                  context.read<QuizBloc>().add(SelectAnswer(option.answer));
                }
              },
            ))
        .toList();
  }
}
