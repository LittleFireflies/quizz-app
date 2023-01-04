import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pausable_timer/pausable_timer.dart';
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
  PausableTimer? countdownTimer;
  static const _quizDuration = 30;
  int currentCountdown = _quizDuration;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer = PausableTimer(
      const Duration(seconds: 1),
      () {
        setCountdown();
      },
    )..start();
  }

  void stopTimer() {
    countdownTimer?.pause();
  }

  void resetTimer() {
    setState(() {
      countdownTimer
        ?..reset()
        ..start();
      currentCountdown = _quizDuration;
    });
  }

  void setCountdown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = currentCountdown - reduceSecondsBy;
      if (seconds < 0) {
        widget.onTimesUp();
      } else {
        currentCountdown = seconds;
        countdownTimer
          ?..reset()
          ..start();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<QuizBloc, QuizState>(
          listenWhen: (p, c) => p.activeQuestionIndex != c.activeQuestionIndex,
          listener: (context, state) {
            resetTimer();
          },
        ),
        BlocListener<QuizBloc, QuizState>(
          listenWhen: (p, c) =>
              c.selectedAnswer.isNotEmpty &&
              p.selectedAnswer != c.selectedAnswer,
          listener: (context, state) {
            stopTimer();
          },
        ),
      ],
      child: LinearProgressIndicator(
        value: currentCountdown / _quizDuration,
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
