import 'package:flutter/material.dart';
import 'package:quizz_app/features/home/view/home_page.dart';
import 'package:quizz_app/features/topics/view/topics_page.dart';
import 'package:quizz_app/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz App',
      theme: QuizzAppTheme.mainTheme(),
      initialRoute: HomePage.routeName,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomePage.routeName:
            return MaterialPageRoute(builder: (context) => const HomePage());
          case TopicsPage.routeName:
            return MaterialPageRoute(builder: (context) => const TopicsPage());
          default:
            return MaterialPageRoute(builder: (_) {
              return const Scaffold(
                body: Center(
                  child: Text('Page not found :('),
                ),
              );
            });
        }
      },
    );
  }
}
