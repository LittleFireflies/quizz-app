import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/extensions/bloc.ext.dart';
import 'package:quizz_app/repositories/quiz_repository.dart';
import 'package:quizz_app/services/firestore/models/topic.dart';

part 'topics_event.dart';
part 'topics_state.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  final QuizRepository _quizRepository;

  List<Topic> _allTopics = [];

  TopicsBloc(QuizRepository quizRepository)
      : _quizRepository = quizRepository,
        super(const TopicsLoading()) {
    on<LoadTopics>((event, emit) => _onLoadTopics(emit));
    on<EnterSearchMode>((event, emit) => _onEnterSearchMode(emit));
    on<ExitSearchMode>((event, emit) => _onExitSearchMode(emit));
    on<SubmitSearchQuery>(
      (event, emit) => _onSubmitSearchQuery(event, emit),
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onLoadTopics(Emitter<TopicsState> emit) async {
    emit(const TopicsLoading());

    try {
      final topics = await _quizRepository.loadTopics();

      if (topics.isNotEmpty) {
        emit(TopicsLoaded(topics: topics));
      } else {
        emit(const TopicsLoadedEmpty());
      }
    } catch (error) {
      emit(TopicsLoadError(error.toString()));
    }
  }

  void _onEnterSearchMode(Emitter<TopicsState> emit) {
    if (state is! TopicsLoaded) return;

    if (_allTopics.isEmpty) {
      _allTopics = (state as TopicsLoaded).topics;
    }

    emit(
      TopicsLoaded(
        topics: (state as TopicsLoaded).topics,
        isSearchActive: true,
      ),
    );
  }

  void _onExitSearchMode(Emitter<TopicsState> emit) {
    if (state is! TopicsLoaded) return;

    emit(
      TopicsLoaded(
        topics: _allTopics,
      ),
    );

    _allTopics = [];
  }

  void _onSubmitSearchQuery(
    SubmitSearchQuery event,
    Emitter<TopicsState> emit,
  ) {
    if (state is! TopicsLoaded) return;

    emit(
      TopicsLoaded(
        topics: _allTopics
            .where(
              (topic) =>
                  topic.name.toLowerCase().contains(event.query.toLowerCase()),
            )
            .toList(),
        isSearchActive: true,
      ),
    );
  }
}
