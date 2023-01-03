import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizz_app/services/firestore/models/question.dart';
import 'package:quizz_app/services/firestore/models/topic.dart';

class FirestoreService {
  late FirebaseFirestore _db;

  FirestoreService() {
    _db = FirebaseFirestore.instance;
  }

  Future<List<Topic>> getTopics() async {
    final topics = await _db.collection('topics').get();

    return topics.docs.map((doc) => Topic.fromFirestore(doc)).toList();
  }

  Future<List<Question>> getQuestionsFromTopic(String topic) async {
    final questions =
        await _db.collection('topics').doc(topic).collection('questions').get();

    return questions.docs.map((doc) => Question.fromFirestore(doc)).toList();
  }
}
