import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/repositories/quiz_repository.dart';

part 'topics_event.dart';
part 'topics_state.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  final QuizRepository _quizRepository;

  TopicsBloc(QuizRepository quizRepository)
      : _quizRepository = quizRepository,
        super(const TopicsLoading()) {
    on<LoadTopics>((event, emit) async {
      emit(const TopicsLoading());

      try {
        final topics = await _quizRepository.loadTopics();

        if (topics.isNotEmpty) {
          emit(TopicsLoaded(topics.map((topic) => topic.name).toList()));
        } else {
          emit(const TopicsLoadedEmpty());
        }
      } catch (error) {
        emit(TopicsLoadError(error.toString()));
      }
    });
  }
}
