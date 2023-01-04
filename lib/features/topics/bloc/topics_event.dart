part of 'topics_bloc.dart';

abstract class TopicsEvent extends Equatable {
  const TopicsEvent();
}

class LoadTopics extends TopicsEvent {
  const LoadTopics();

  @override
  List<Object?> get props => [];
}

class EnterSearchMode extends TopicsEvent {
  const EnterSearchMode();

  @override
  List<Object?> get props => [];
}

class ExitSearchMode extends TopicsEvent {
  const ExitSearchMode();

  @override
  List<Object?> get props => [];
}

class SubmitSearchQuery extends TopicsEvent {
  final String query;

  const SubmitSearchQuery(this.query);

  @override
  List<Object?> get props => [query];
}
