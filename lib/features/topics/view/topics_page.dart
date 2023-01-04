import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/core/shared_widgets/quizz_error_view.dart';
import 'package:quizz_app/features/quiz/view/quiz_page.dart';
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

class TopicsView extends StatefulWidget {
  const TopicsView({
    Key? key,
  }) : super(key: key);

  @override
  State<TopicsView> createState() => _TopicsViewState();
}

class _TopicsViewState extends State<TopicsView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context.read<TopicsBloc>().add(SubmitSearchQuery(_searchController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TopicsBloc, TopicsState>(
          buildWhen: (p, c) => c is TopicsLoaded,
          builder: (context, state) {
            if (state is TopicsLoaded && state.isSearchActive) {
              return TextField(
                controller: _searchController,
                autofocus: true,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search topics',
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_searchController.text.isEmpty) {
                        context.read<TopicsBloc>().add(const ExitSearchMode());
                      } else {
                        _searchController.clear();
                      }
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              );
            }

            return const Text('Topics');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TopicsBloc>().add(const EnterSearchMode());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<TopicsBloc, TopicsState>(
          builder: (context, state) {
            if (state is TopicsLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final topic = state.topics[index];
                  return Card(
                    child: ListTile(
                      title: Text(topic.name),
                      trailing: const Icon(Icons.play_arrow),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          QuizPage.routeName,
                          arguments: topic.key,
                        );
                      },
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
