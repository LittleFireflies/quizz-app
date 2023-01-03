import 'package:flutter/material.dart';
import 'package:quizz_app/theme/typography.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          ElevatedButton(
            onPressed: () {},
            child: const Text('PLAY'),
          ),
          OutlinedButton(
            onPressed: () {},
            child: const Text('TOPICS'),
          ),
        ],
      ),
    );
  }
}
