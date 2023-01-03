part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final List<Question> questions;
  final int activeQuestionIndex;
  final String selectedAnswer;
  final bool isLastQuestion;

  const QuizState({
    required this.questions,
    required this.activeQuestionIndex,
    this.selectedAnswer = '',
    this.isLastQuestion = false,
  });

  @override
  List<Object?> get props => [
        questions,
        activeQuestionIndex,
        selectedAnswer,
        isLastQuestion,
      ];

  QuizState copyWith({
    List<Question>? questions,
    int? activeQuestionIndex,
    String? selectedAnswer,
    bool? isLastQuestion,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      activeQuestionIndex: activeQuestionIndex ?? this.activeQuestionIndex,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      isLastQuestion: isLastQuestion ?? this.isLastQuestion,
    );
  }
}
