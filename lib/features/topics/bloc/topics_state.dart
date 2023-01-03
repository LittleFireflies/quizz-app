part of 'topics_bloc.dart';

abstract class TopicsState extends Equatable {
  const TopicsState();
}

class TopicsLoading extends TopicsState {
  const TopicsLoading();

  @override
  List<Object> get props => [];
}

class TopicsLoaded extends TopicsState {
  final List<String> topics;

  const TopicsLoaded(this.topics);

  @override
  List<Object?> get props => [topics];
}

class TopicsLoadedEmpty extends TopicsState {
  const TopicsLoadedEmpty();

  @override
  List<Object?> get props => [];
}

class TopicsLoadError extends TopicsState {
  final String message;

  const TopicsLoadError(this.message);

  @override
  List<Object?> get props => [message];
}
