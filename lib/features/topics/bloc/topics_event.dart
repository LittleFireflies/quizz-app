part of 'topics_bloc.dart';

abstract class TopicsEvent extends Equatable {
  const TopicsEvent();
}

class LoadTopics extends TopicsEvent {
  const LoadTopics();

  @override
  List<Object?> get props => [];
}
