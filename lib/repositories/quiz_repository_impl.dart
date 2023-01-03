import 'dart:math';

import 'package:quizz_app/repositories/quiz_repository.dart';
import 'package:quizz_app/services/firestore/firestore_service.dart';
import 'package:quizz_app/services/firestore/models/question.dart';
import 'package:quizz_app/services/firestore/models/topic.dart';

class QuizRepositoryImpl implements QuizRepository {
  final FirestoreService _firestoreService;

  const QuizRepositoryImpl({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;

  @override
  Future<List<Topic>> loadTopics() async {
    final topics = await _firestoreService.getTopics();

    return topics;
  }

  @override
  Future<List<Question>> loadQuestionsFromTopic(
    String topic, {
    int maxQuestion = 5,
  }) async {
    final questions = await _firestoreService.getQuestionsFromTopic(topic);
    final filteredQuestion = <Question>[];

    if (questions.length > maxQuestion) {
      final selectedIndex = <int>[];
      final random = Random();
      while (selectedIndex.length < maxQuestion) {
        final index = random.nextInt(maxQuestion);
        if (!selectedIndex.contains(index)) {
          selectedIndex.add(index);
          filteredQuestion.add(questions[index]);
        }
      }
    } else {
      filteredQuestion.addAll(questions);
    }

    return filteredQuestion;
  }
}
