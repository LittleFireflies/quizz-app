import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/utils/quizz_randomizer.dart';
import 'package:quizz_app/features/home/view/home_page.dart';
import 'package:quizz_app/features/topics/view/topics_page.dart';
import 'package:quizz_app/features/view/quiz_page.dart';
import 'package:quizz_app/firebase_options.dart';
import 'package:quizz_app/repositories/quiz_repository_impl.dart';
import 'package:quizz_app/services/firestore/firestore_service.dart';
import 'package:quizz_app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => QuizRepositoryImpl(
            firestoreService: FirestoreService(),
          ),
        ),
        RepositoryProvider(create: (context) => QuizzRandomizer()),
      ],
      child: MaterialApp(
        title: 'Quizz App',
        theme: QuizzAppTheme.mainTheme(),
        initialRoute: HomePage.routeName,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.routeName:
              return MaterialPageRoute(builder: (context) => const HomePage());
            case TopicsPage.routeName:
              return MaterialPageRoute(
                  builder: (context) => const TopicsPage());
            case QuizPage.routeName:
              final topic = settings.arguments as String?;

              return MaterialPageRoute(
                builder: (context) => QuizPage(topic: topic),
              );
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
      ),
    );
  }
}
