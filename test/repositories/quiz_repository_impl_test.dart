import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quizz_app/repositories/quiz_repository_impl.dart';
import 'package:quizz_app/services/firestore/firestore_service.dart';

import '../helpers/test_models.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  group('QuizRepositoryImpl', () {
    late FirestoreService firestoreService;
    late QuizRepositoryImpl repository;

    final topics = [TestModels.topicA, TestModels.topicB];
    final questions = [
      TestModels.question1,
      TestModels.question2,
      TestModels.question3,
    ];

    final questionsMoreThanFive = [
      TestModels.question1,
      TestModels.question2,
      TestModels.question3,
      TestModels.question1,
      TestModels.question2,
      TestModels.question3,
    ];

    setUp(() {
      firestoreService = MockFirestoreService();
      repository = QuizRepositoryImpl(firestoreService: firestoreService);
    });

    test(
      'should call service.getTopics() '
      'and return list of topics '
      'when loadTopics is called',
      () async {
        when(() => firestoreService.getTopics())
            .thenAnswer((_) async => topics);

        final result = await repository.loadTopics();

        expect(result, topics);
        verify(() => firestoreService.getTopics()).called(1);
      },
    );

    test(
      'should call service.getQuestionFromTopic() '
      'and return list of questions '
      'when loadQuestionsFromTopic is called',
      () async {
        when(() => firestoreService.getQuestionsFromTopic(any()))
            .thenAnswer((_) async => questions);

        final result = await repository.loadQuestionsFromTopic('topic');

        expect(result, questions);
        verify(() => firestoreService.getQuestionsFromTopic('topic')).called(1);
      },
    );

    test(
      'should call service.getQuestionFromTopic() '
      'and return list of 5 questions  '
      'when loadQuestionsFromTopic is called '
      'and questions from service are more than 5',
      () async {
        when(() => firestoreService.getQuestionsFromTopic(any()))
            .thenAnswer((_) async => questionsMoreThanFive);

        final result = await repository.loadQuestionsFromTopic('topic');

        expect(result.length, 5);
        verify(() => firestoreService.getQuestionsFromTopic('topic')).called(1);
      },
    );
  });
}
