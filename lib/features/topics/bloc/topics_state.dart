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
  final List<Topic> topics;
  final bool isSearchActive;

  const TopicsLoaded({
    required this.topics,
    this.isSearchActive = false,
  });

  @override
  List<Object?> get props => [topics, isSearchActive];

  TopicsLoaded copyWith({
    List<Topic>? topics,
    bool? isSearchActive,
  }) {
    return TopicsLoaded(
      topics: topics ?? this.topics,
      isSearchActive: isSearchActive ?? this.isSearchActive,
    );
  }
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
