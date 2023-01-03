import 'package:quizz_app/services/firestore/models/question.dart';
import 'package:quizz_app/services/firestore/models/topic.dart';

abstract class QuizRepository {
  Future<List<Topic>> loadTopics();
  Future<List<Question>> loadQuestionsFromTopic(
    String topic, {
    int maxQuestion = 5,
  });
}
