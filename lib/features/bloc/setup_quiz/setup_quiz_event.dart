part of 'setup_quiz_bloc.dart';

abstract class SetupQuizEvent extends Equatable {
  const SetupQuizEvent();
}

class LoadQuizQuestion extends SetupQuizEvent {
  final String? topic;

  const LoadQuizQuestion({this.topic});

  @override
  List<Object?> get props => [topic];
}
