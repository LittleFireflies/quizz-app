import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizz_app/features/quiz/bloc/quiz_bloc.dart';
import 'package:quizz_app/features/quiz/models/answer_history.dart';

import '../../../helpers/test_models.dart';

void main() {
  group('QuizBloc', () {
    late QuizBloc quizBloc;

    final questions = [
      TestModels.question1,
      TestModels.question2,
      TestModels.question3,
    ];

    setUp(() {
      quizBloc = QuizBloc();
    });

    blocTest(
      'should emit state with first question '
      'when InitQuiz is added',
      build: () => quizBloc,
      act: (bloc) => bloc.add(InitQuiz(questions)),
      expect: () => [
        QuizState(
          questions: questions,
          activeQuestionIndex: 0,
          quizResult: const [],
        ),
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'should emit state with selectedAnswer '
      'when SelectAnswer is added',
      build: () => quizBloc,
      seed: () => QuizState(
        questions: questions,
        activeQuestionIndex: 0,
        quizResult: const [],
      ),
      act: (bloc) => bloc.add(const SelectAnswer('Apples')),
      expect: () => [
        QuizState(
          questions: questions,
          activeQuestionIndex: 0,
          selectedAnswer: 'Apples',
          quizResult: const [],
        ),
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'should emit state with next index questions '
      'and add answer history '
      'and reset selected answer to empty '
      'when OpenNextQuestion is added',
      build: () => quizBloc,
      seed: () => QuizState(
        questions: questions,
        activeQuestionIndex: 0,
        selectedAnswer: 'Apples',
        quizResult: const [],
      ),
      act: (bloc) => bloc.add(const OpenNextQuestion()),
      expect: () => [
        QuizState(
          questions: questions,
          activeQuestionIndex: 1,
          selectedAnswer: '',
          quizResult: [
            AnswerHistory(
              question: TestModels.question1.question,
              answer: 'Apples',
              correctAnswer: TestModels.question1.correctAnswer,
            ),
          ],
        ),
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'should emit state with next index questions '
      'and reset selected answer to empty '
      'and add answer history '
      'and set as last question '
      'when OpenNextQuestion is added '
      'and the next index is the last possible question',
      build: () => quizBloc,
      seed: () => QuizState(
        questions: questions,
        activeQuestionIndex: 1,
        quizResult: [
          AnswerHistory(
            question: TestModels.question1.question,
            answer: 'Apples',
            correctAnswer: TestModels.question1.correctAnswer,
          ),
        ],
      ),
      act: (bloc) => bloc.add(const OpenNextQuestion()),
      expect: () => [
        QuizState(
          questions: questions,
          activeQuestionIndex: 2,
          selectedAnswer: '',
          isLastQuestion: true,
          quizResult: [
            AnswerHistory(
              question: TestModels.question1.question,
              answer: 'Apples',
              correctAnswer: TestModels.question1.correctAnswer,
            ),
            AnswerHistory(
              question: TestModels.question2.question,
              answer: '',
              correctAnswer: TestModels.question2.correctAnswer,
            ),
          ],
        ),
      ],
    );
  });
}
