import 'package:flutter/material.dart';
import 'package:quizz_app/core/constants.dart';
import 'package:quizz_app/core/shared_widgets/quizz_primary_button.dart';
import 'package:quizz_app/core/shared_widgets/quizz_secondary_button.dart';
import 'package:quizz_app/core/shared_widgets/quizz_text_button.dart';
import 'package:quizz_app/features/quiz/view/quiz_page.dart';
import 'package:quizz_app/features/topics/view/topics_page.dart';
import 'package:quizz_app/theme/typography.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'homePage';

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
              onPressed: () {
                Navigator.pushNamed(context, QuizPage.routeName);
              },
              label: 'PLAY',
            ),
            const SizedBox(height: 8),
            QuizzSecondaryButton(
              onPressed: () {
                Navigator.pushNamed(context, TopicsPage.routeName);
              },
              label: 'TOPICS',
            ),
            const SizedBox(height: 16),
            QuizzTextButton(
              onPressed: () {
                Share.share(
                  "Hey 👋 Let's play Quizz App!\nYou can download the app here: $appLink",
                );
              },
              label: 'Share',
              leading: const Icon(Icons.share),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
