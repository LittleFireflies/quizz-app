import 'package:equatable/equatable.dart';
import 'package:quizz_app/features/quiz/models/answer_history.dart';

class QuizResult extends Equatable {
  final List<AnswerHistory> answers;

  const QuizResult({
    required this.answers,
  });

  @override
  List<Object?> get props => [answers];
}
