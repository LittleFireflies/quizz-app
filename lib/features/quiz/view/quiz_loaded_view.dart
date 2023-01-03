import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/shared_widgets/quizz_primary_button.dart';
import 'package:quizz_app/features/quiz/bloc/quiz_bloc.dart';
import 'package:quizz_app/features/quiz/widgets/answer_card.dart';
import 'package:quizz_app/features/quiz/widgets/question_card.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Theme(
              data: QuizzAppTheme.createQuizCardTheme(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  QuestionCard(question: activeQuestion),
                  const SizedBox(height: 16),
                  AnswerCard(
                    text: activeQuestion.option1,
                    selected: activeQuestion.option1 == state.selectedAnswer,
                  ),
                  AnswerCard(
                    text: activeQuestion.option2,
                    selected: activeQuestion.option2 == state.selectedAnswer,
                  ),
                  AnswerCard(
                    text: activeQuestion.option3,
                    selected: activeQuestion.option3 == state.selectedAnswer,
                  ),
                  AnswerCard(
                    text: activeQuestion.option4,
                    selected: activeQuestion.option4 == state.selectedAnswer,
                  ),
                  const Spacer(),
                  Visibility(
                    visible: state.selectedAnswer != '',
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
