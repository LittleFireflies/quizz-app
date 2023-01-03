import 'package:equatable/equatable.dart';

class AnswerHistory extends Equatable {
  final String question;
  final String answer;
  final String correctAnswer;

  const AnswerHistory({
    required this.question,
    required this.answer,
    required this.correctAnswer,
  });

  @override
  List<Object?> get props => [
        question,
        answer,
        correctAnswer,
      ];
}
