import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/shared_widgets/quizz_error_view.dart';
import 'package:quizz_app/core/shared_widgets/quizz_text_button.dart';
import 'package:quizz_app/core/utils/quizz_randomizer.dart';
import 'package:quizz_app/features/quiz/bloc/quiz_bloc.dart';
import 'package:quizz_app/features/quiz/bloc/setup_quiz/setup_quiz_bloc.dart';
import 'package:quizz_app/features/quiz/view/quiz_loaded_view.dart';
import 'package:quizz_app/repositories/quiz_repository_impl.dart';

class QuizPage extends StatelessWidget {
  static const routeName = 'quizPage';

  final String? topic;

  const QuizPage({Key? key, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SetupQuizBloc(
            quizRepository: context.read<QuizRepositoryImpl>(),
            randomizer: context.read<QuizzRandomizer>(),
          )..add(LoadQuizQuestion(topic: topic)),
        ),
        BlocProvider(
          create: (context) => QuizBloc(),
        ),
      ],
      child: QuizView(topic: topic),
    );
  }
}

class QuizView extends StatelessWidget {
  final String? topic;

  const QuizView({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Exit Quiz'),
                content: const Text('Are you sure to exit the quiz?'),
                actions: [
                  QuizzTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: 'No',
                  ),
                  QuizzTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    label: 'Yes',
                  ),
                ],
              );
            });

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Page'),
        ),
        body: BlocConsumer<SetupQuizBloc, SetupQuizState>(
          listener: (context, state) {
            if (state is QuizLoaded) {
              context.read<QuizBloc>().add(InitQuiz(state.questions));
            }
          },
          builder: (context, state) {
            if (state is QuizLoaded) {
              return QuizLoadedView(
                questions: state.questions,
              );
            } else if (state is QuizLoadError) {
              return QuizzErrorView(
                errorMessage: state.message,
                onRetryButtonPressed: () {
                  context
                      .read<SetupQuizBloc>()
                      .add(LoadQuizQuestion(topic: topic));
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
