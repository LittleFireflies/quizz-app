part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final List<Question> questions;
  final int activeQuestionIndex;
  final String selectedAnswer;
  final bool isLastQuestion;
  final List<AnswerHistory> quizResult;
  final bool isFinished;

  const QuizState({
    required this.questions,
    required this.activeQuestionIndex,
    this.selectedAnswer = '',
    this.isLastQuestion = false,
    required this.quizResult,
    this.isFinished = false,
  });

  @override
  List<Object?> get props => [
        questions,
        activeQuestionIndex,
        selectedAnswer,
        isLastQuestion,
        quizResult,
        isFinished,
      ];

  QuizState copyWith({
    List<Question>? questions,
    int? activeQuestionIndex,
    String? selectedAnswer,
    bool? isLastQuestion,
    List<AnswerHistory>? quizResult,
    bool? isFinished,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      activeQuestionIndex: activeQuestionIndex ?? this.activeQuestionIndex,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      isLastQuestion: isLastQuestion ?? this.isLastQuestion,
      quizResult: quizResult ?? this.quizResult,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
