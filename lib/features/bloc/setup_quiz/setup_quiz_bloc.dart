import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/utils/quizz_randomizer.dart';
import 'package:quizz_app/repositories/quiz_repository.dart';
import 'package:quizz_app/services/firestore/models/question.dart';

part 'setup_quiz_event.dart';
part 'setup_quiz_state.dart';

class SetupQuizBloc extends Bloc<SetupQuizEvent, SetupQuizState> {
  final QuizRepository _quizRepository;
  final QuizzRandomizer _randomizer;

  SetupQuizBloc({
    required QuizRepository quizRepository,
    required QuizzRandomizer randomizer,
  })  : _quizRepository = quizRepository,
        _randomizer = randomizer,
        super(SetupQuizInitial()) {
    on<LoadQuizQuestion>((event, emit) async {
      emit(const QuizLoading());

      try {
        final topic = event.topic;
        if (topic != null) {
          final questions = await _quizRepository.loadQuestionsFromTopic(topic);

          emit(QuizLoaded(questions));
        } else {
          final topics = await _quizRepository.loadTopics();
          final randomIndex = _randomizer.randomInt(topics.length);

          final questions = await _quizRepository
              .loadQuestionsFromTopic(topics[randomIndex].key);

          emit(QuizLoaded(questions));
        }
      } catch (error) {
        emit(QuizLoadError(error.toString()));
      }
    });
  }
}
