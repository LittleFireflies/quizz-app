import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/features/quiz/bloc/quiz_bloc.dart';

class QuizTimer extends StatefulWidget {
  final VoidCallback onTimesUp;

  const QuizTimer({
    Key? key,
    required this.onTimesUp,
  }) : super(key: key);

  @override
  State<QuizTimer> createState() => _QuizTimerState();
}

class _QuizTimerState extends State<QuizTimer> {
  Timer? countdownTimer;
  static const _quizDuration = Duration(seconds: 30);
  Duration currentDuration = _quizDuration;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setCountdown();
      },
    );
  }

  void resetTimer() {
    setState(() => currentDuration = _quizDuration);
  }

  void setCountdown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = currentDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        widget.onTimesUp();
        resetTimer();
      } else {
        currentDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizBloc, QuizState>(
      listenWhen: (p, c) => p.activeQuestionIndex != c.activeQuestionIndex,
      listener: (context, state) {
        resetTimer();
      },
      child: LinearProgressIndicator(
        value: currentDuration.inSeconds / _quizDuration.inSeconds,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }
}
