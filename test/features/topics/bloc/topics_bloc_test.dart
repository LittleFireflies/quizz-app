import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quizz_app/features/topics/bloc/topics_bloc.dart';
import 'package:quizz_app/repositories/quiz_repository.dart';

class MockQuizRepository extends Mock implements QuizRepository {}

void main() {
  group('TopicsBloc', () {
    late QuizRepository quizRepository;
    late TopicsBloc topicsBloc;

    const topics = ['Topic A', 'Topic B'];

    final exception = Exception('Error!');

    setUp(() {
      quizRepository = MockQuizRepository();
      topicsBloc = TopicsBloc(quizRepository);
    });

    blocTest(
      'should emit TopicsLoaded '
      'when LoadTopics event is added '
      'and repository return list of topics',
      setUp: () {
        when(() => quizRepository.loadTopics()).thenAnswer((_) async => topics);
      },
      build: () => topicsBloc,
      act: (bloc) => bloc.add(const LoadTopics()),
      expect: () => [
        const TopicsLoading(),
        const TopicsLoaded(topics),
      ],
      verify: (_) {
        verify(() => quizRepository.loadTopics()).called(1);
      },
    );

    blocTest(
      'should emit TopicsLoadedEmpty '
      'when LoadTopics event is added '
      'and repository return empty list',
      setUp: () {
        when(() => quizRepository.loadTopics()).thenAnswer((_) async => []);
      },
      build: () => topicsBloc,
      act: (bloc) => bloc.add(const LoadTopics()),
      expect: () => [
        const TopicsLoading(),
        const TopicsLoadedEmpty(),
      ],
      verify: (_) {
        verify(() => quizRepository.loadTopics()).called(1);
      },
    );

    blocTest(
      'should emit TopicsLoadError '
      'when LoadTopics event is added '
      'and repository throws an exception',
      setUp: () {
        when(() => quizRepository.loadTopics()).thenThrow(exception);
      },
      build: () => topicsBloc,
      act: (bloc) => bloc.add(const LoadTopics()),
      expect: () => [
        const TopicsLoading(),
        TopicsLoadError(exception.toString()),
      ],
      verify: (_) {
        verify(() => quizRepository.loadTopics()).called(1);
      },
    );
  });
}
