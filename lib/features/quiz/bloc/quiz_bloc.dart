import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/features/quiz/models/answer_history.dart';
import 'package:quizz_app/features/quiz/models/answer_option.dart';
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
            answerOptions: [],
          ),
        ) {
    on<InitQuiz>((event, emit) => _onInitQuiz(emit, event));
    on<SelectAnswer>((event, emit) => _onSelectAnswer(emit, event));
    on<OpenNextQuestion>((event, emit) => _onOpenNextQuestion(emit));
    on<SeeResults>((event, emit) => _onSeeResults(emit));
  }

  void _onInitQuiz(Emitter<QuizState> emit, InitQuiz event) {
    final question = event.questions[0];

    final answerOptions = _getAnswerOptions(question);

    emit(
      state.copyWith(
        questions: event.questions,
        activeQuestionIndex: 0,
        answerOptions: answerOptions,
      ),
    );
  }

  void _onSelectAnswer(Emitter<QuizState> emit, SelectAnswer event) {
    emit(
      state.copyWith(
        selectedAnswer: event.selectedAnswer,
      ),
    );
  }

  void _onOpenNextQuestion(Emitter<QuizState> emit) {
    final nextIndex = state.activeQuestionIndex + 1;
    final question = state.questions[state.activeQuestionIndex];
    final quizResult = List<AnswerHistory>.from(state.quizResult);
    final nextQuestion = state.questions[nextIndex];
    final answerOptions = _getAnswerOptions(nextQuestion);

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
        answerOptions: answerOptions,
        isLastQuestion: nextIndex == state.questions.length - 1,
        quizResult: quizResult,
      ),
    );
  }

  void _onSeeResults(Emitter<QuizState> emit) {
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
        selectedAnswer: '',
        quizResult: quizResult,
        isFinished: true,
      ),
    );
  }

  List<AnswerOption> _getAnswerOptions(Question question) {
    final List<AnswerOption> answerOptions = <AnswerOption>[];

    answerOptions.add(
      AnswerOption(
        answer: question.option1,
        isCorrectAnswer: question.option1 == question.correctAnswer,
      ),
    );
    answerOptions.add(
      AnswerOption(
        answer: question.option2,
        isCorrectAnswer: question.option2 == question.correctAnswer,
      ),
    );
    answerOptions.add(
      AnswerOption(
        answer: question.option3,
        isCorrectAnswer: question.option3 == question.correctAnswer,
      ),
    );
    answerOptions.add(
      AnswerOption(
        answer: question.option4,
        isCorrectAnswer: question.option4 == question.correctAnswer,
      ),
    );

    return answerOptions;
  }
}
