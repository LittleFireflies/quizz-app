import 'package:flutter/material.dart';

class TopicsEmptyView extends StatelessWidget {
  const TopicsEmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.quiz_outlined,
            size: 80,
          ),
          SizedBox(height: 28),
          Text(
            "We don't have any topics yet",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
