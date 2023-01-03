import 'package:flutter/material.dart';

class QuizzErrorView extends StatelessWidget {
  final String errorMessage;

  const QuizzErrorView({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 80,
          ),
          const SizedBox(height: 28),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
