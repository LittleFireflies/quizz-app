import 'package:flutter/material.dart';

class TopicsPage extends StatelessWidget {
  static const routeName = 'topicsPage';

  const TopicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return const Card(
              child: ListTile(
                title: Text('Topics'),
                trailing: Icon(Icons.chevron_right),
              ),
            );
          },
          itemCount: 4,
        ),
      ),
    );
  }
}
