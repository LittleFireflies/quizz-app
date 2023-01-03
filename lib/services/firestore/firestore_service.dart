import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizz_app/services/firestore/models/topic.dart';

class FirestoreService {
  late FirebaseFirestore _db;

  FirestoreService() {
    _db = FirebaseFirestore.instance;
  }

  Future<List<String>> getTopics() async {
    final topics = await _db.collection('topics').get();

    return topics.docs.map((doc) => Topic.fromFirestore(doc).name).toList();
  }
}
