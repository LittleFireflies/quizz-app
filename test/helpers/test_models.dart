import 'package:quizz_app/services/firestore/models/question.dart';
import 'package:quizz_app/services/firestore/models/topic.dart';

class TestModels {
  static const topicA = Topic(
    key: 'topic-A',
    name: 'Topic A',
  );

  static const topicB = Topic(
    key: 'topic-B',
    name: 'Topic B',
  );

  static const question1 = Question(
    key: 'Q-1',
    question: 'Which fruit is Isaac Newton associated with?',
    option1: 'Apples',
    option2: 'Mangoes',
    option3: 'Durians',
    option4: 'Grapes',
    correctAnswer: 'Apples',
  );

  static const question2 = Question(
    key: 'Q-2',
    question: "What is Earth's only natural satellite?",
    option1: 'Sun',
    option2: 'Moon',
    option3: 'Mars',
    option4: 'Jupiter',
    correctAnswer: 'Moon',
  );
}
