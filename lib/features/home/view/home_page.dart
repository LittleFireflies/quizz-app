import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.quiz,
            size: 80,
          ),
          SizedBox(height: 20),
          Text(
            'Flutter Quiz App',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
