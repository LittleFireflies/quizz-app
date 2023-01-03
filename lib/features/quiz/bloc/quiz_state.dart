part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final List<Question> questions;
  final int activeQuestionIndex;
  final String selectedAnswer;
  final bool isLastQuestion;
  final List<AnswerHistory> quizResult;

  const QuizState({
    required this.questions,
    required this.activeQuestionIndex,
    this.selectedAnswer = '',
    this.isLastQuestion = false,
    required this.quizResult,
  });

  @override
  List<Object?> get props => [
        questions,
        activeQuestionIndex,
        selectedAnswer,
        isLastQuestion,
        quizResult,
      ];

  QuizState copyWith({
    List<Question>? questions,
    int? activeQuestionIndex,
    String? selectedAnswer,
    bool? isLastQuestion,
    List<AnswerHistory>? quizResult,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      activeQuestionIndex: activeQuestionIndex ?? this.activeQuestionIndex,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      isLastQuestion: isLastQuestion ?? this.isLastQuestion,
      quizResult: quizResult ?? this.quizResult,
    );
  }
}
