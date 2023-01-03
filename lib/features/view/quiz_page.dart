import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/shared_widgets/quizz_error_view.dart';
import 'package:quizz_app/core/utils/quizz_randomizer.dart';
import 'package:quizz_app/features/bloc/setup_quiz/setup_quiz_bloc.dart';
import 'package:quizz_app/repositories/quiz_repository_impl.dart';
import 'package:quizz_app/services/firestore/models/question.dart';
import 'package:quizz_app/theme/theme.dart';
import 'package:quizz_app/theme/typography.dart';

class QuizPage extends StatelessWidget {
  static const routeName = 'quizPage';

  final String? topic;

  const QuizPage({Key? key, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetupQuizBloc(
        quizRepository: context.read<QuizRepositoryImpl>(),
        randomizer: context.read<QuizzRandomizer>(),
      )..add(LoadQuizQuestion(topic: topic)),
      child: const QuizView(),
    );
  }
}

class QuizView extends StatelessWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
      ),
      body: BlocBuilder<SetupQuizBloc, SetupQuizState>(
        builder: (context, state) {
          if (state is QuizLoaded) {
            return QuizLoadedView(
              questions: state.questions,
            );
          } else if (state is QuizLoadError) {
            return QuizzErrorView(errorMessage: state.message);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class QuizLoadedView extends StatelessWidget {
  final List<Question> questions;

  const QuizLoadedView({
    Key? key,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Theme(
        data: QuizzAppTheme.createQuizCardTheme(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuestionCard(question: questions[0]),
            const SizedBox(height: 16),
            AnswerCard(text: questions[0].option1),
            AnswerCard(text: questions[0].option2),
            AnswerCard(text: questions[0].option3),
            AnswerCard(text: questions[0].option4),
          ],
        ),
      ),
    );
  }
}

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

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.quizAnswer,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
