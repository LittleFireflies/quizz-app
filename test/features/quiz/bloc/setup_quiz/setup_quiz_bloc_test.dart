import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quizz_app/core/utils/quizz_randomizer.dart';
import 'package:quizz_app/features/quiz/bloc/setup_quiz/setup_quiz_bloc.dart';
import 'package:quizz_app/repositories/quiz_repository.dart';

import '../../../../helpers/test_models.dart';

class MockQuizRepository extends Mock implements QuizRepository {}

class MockRandomizer extends Mock implements QuizzRandomizer {}

void main() {
  group('SetupQuizBloc', () {
    late QuizRepository quizRepository;
    late QuizzRandomizer randomizer;
    late SetupQuizBloc bloc;

    const topic = TestModels.topicA;
    const questions = [TestModels.question1, TestModels.question2];

    final exception = Exception('Error!');

    setUp(() {
      quizRepository = MockQuizRepository();
      randomizer = MockRandomizer();
      bloc = SetupQuizBloc(
        quizRepository: quizRepository,
        randomizer: randomizer,
      );
    });

    blocTest(
      'should emit QuizLoaded '
      'when LoadQuizQuestions is added '
      'and repository returns list of questions successfully',
      setUp: () {
        when(() => quizRepository.loadQuestionsFromTopic(topic.key))
            .thenAnswer((_) async => questions);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(LoadQuizQuestion(topic: topic.key)),
      expect: () => [
        const QuizLoading(),
        const QuizLoaded(questions),
      ],
      verify: (_) {
        verify(() => quizRepository.loadQuestionsFromTopic(topic.key))
            .called(1);
      },
    );

    blocTest(
      'should emit QuizLoaded '
      'and call randomizer '
      'when LoadQuizQuestions is added without topic '
      'and repository returns list of questions successfully',
      setUp: () {
        when(() => randomizer.randomInt(any())).thenReturn(0);
        when(() => quizRepository.loadTopics())
            .thenAnswer((_) async => [topic]);
        when(() => quizRepository.loadQuestionsFromTopic(topic.key))
            .thenAnswer((_) async => questions);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const LoadQuizQuestion()),
      expect: () => [
        const QuizLoading(),
        const QuizLoaded(questions),
      ],
      verify: (_) {
        verify(() => quizRepository.loadQuestionsFromTopic(topic.key))
            .called(1);
      },
    );

    blocTest(
      'should emit QuizLoadError '
      'when LoadQuizQuestions is added '
      'and repository throws an exception',
      setUp: () {
        when(() => quizRepository.loadQuestionsFromTopic(topic.key))
            .thenThrow(exception);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(LoadQuizQuestion(topic: topic.key)),
      expect: () => [
        const QuizLoading(),
        QuizLoadError(exception.toString()),
      ],
      verify: (_) {
        verify(() => quizRepository.loadQuestionsFromTopic(topic.key))
            .called(1);
      },
    );
  });
}
