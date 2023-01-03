import 'package:quizz_app/repositories/quiz_repository.dart';
import 'package:quizz_app/services/firestore/firestore_service.dart';

class QuizRepositoryImpl implements QuizRepository {
  final FirestoreService _firestoreService;

  const QuizRepositoryImpl({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;

  @override
  Future<List<String>> loadTopics() async {
    final topics = await _firestoreService.getTopics();

    print(topics);

    return Future.value(topics);
  }
}
