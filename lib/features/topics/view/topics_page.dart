import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/shared_widgets/quizz_error_view.dart';
import 'package:quizz_app/features/topics/bloc/topics_bloc.dart';
import 'package:quizz_app/features/topics/view/topics_empty_view.dart';
import 'package:quizz_app/repositories/quiz_repository_impl.dart';

class TopicsPage extends StatelessWidget {
  static const routeName = 'topicsPage';

  const TopicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopicsBloc(
        context.read<QuizRepositoryImpl>(),
      )..add(const LoadTopics()),
      child: const TopicsView(),
    );
  }
}

class TopicsView extends StatelessWidget {
  const TopicsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<TopicsBloc, TopicsState>(
          builder: (context, state) {
            if (state is TopicsLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final topicName = state.topics[index];
                  return Card(
                    child: ListTile(
                      title: Text(topicName),
                      trailing: const Icon(Icons.play_arrow),
                    ),
                  );
                },
                itemCount: state.topics.length,
              );
            } else if (state is TopicsLoadedEmpty) {
              return const TopicsEmptyView();
            } else if (state is TopicsLoadError) {
              return QuizzErrorView(errorMessage: state.message);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
