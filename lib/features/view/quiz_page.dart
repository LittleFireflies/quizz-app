import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/shared_widgets/quizz_error_view.dart';
import 'package:quizz_app/core/utils/quizz_randomizer.dart';
import 'package:quizz_app/features/bloc/setup_quiz/setup_quiz_bloc.dart';
import 'package:quizz_app/repositories/quiz_repository_impl.dart';

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
            return Text(state.questions.toString());
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
