import 'package:flutter/material.dart';
import 'package:quizz_app/core/shared_widgets/quizz_primary_button.dart';
import 'package:quizz_app/core/shared_widgets/quizz_secondary_button.dart';
import 'package:quizz_app/theme/typography.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.quiz,
              size: 80,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 28),
            Text(
              'Flutter Quiz App',
              style: Theme.of(context).textTheme.appTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Learn • Take Quiz • Repeat',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            QuizzPrimaryButton(
              onPressed: () {},
              label: 'PLAY',
            ),
            const SizedBox(height: 8),
            QuizzSecondaryButton(
              onPressed: () {},
              label: 'TOPICS',
            ),
          ],
        ),
      ),
    );
  }
}
