import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/features/quiz/models/answer_history.dart';
import 'package:quizz_app/services/firestore/models/question.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc()
      : super(
          const QuizState(
            questions: [],
            activeQuestionIndex: 0,
            quizResult: [],
          ),
        ) {
    on<InitQuiz>((event, emit) {
      emit(
        state.copyWith(
          questions: event.questions,
          activeQuestionIndex: 0,
        ),
      );
    });
    on<SelectAnswer>((event, emit) {
      emit(
        state.copyWith(
          selectedAnswer: event.selectedAnswer,
        ),
      );
    });
    on<OpenNextQuestion>((event, emit) {
      final nextIndex = state.activeQuestionIndex + 1;
      final question = state.questions[state.activeQuestionIndex];
      final quizResult = List<AnswerHistory>.from(state.quizResult);
      quizResult.add(
        AnswerHistory(
          question: question.question,
          answer: state.selectedAnswer,
          correctAnswer: question.correctAnswer,
        ),
      );

      emit(
        state.copyWith(
          activeQuestionIndex: nextIndex,
          selectedAnswer: '',
          isLastQuestion: nextIndex == state.questions.length - 1,
          quizResult: quizResult,
        ),
      );
    });
  }
}