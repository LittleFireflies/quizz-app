import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quizz_app/core/shared_widgets/quizz_error_view.dart';
import 'package:quizz_app/features/topics/bloc/topics_bloc.dart';
import 'package:quizz_app/features/topics/view/topics_empty_view.dart';
import 'package:quizz_app/features/topics/view/topics_page.dart';

class MockTopicsBloc extends MockBloc<TopicsEvent, TopicsState>
    implements TopicsBloc {}

void main() {
  group('TopicsPage', () {
    late TopicsBloc topicsBloc;

    const topics = ['Topic A', 'Topic B'];

    setUp(() {
      topicsBloc = MockTopicsBloc();
    });

    Widget buildBlocProvider({required Widget child}) {
      return BlocProvider.value(
        value: topicsBloc,
        child: child,
      );
    }

    testWidgets(
      'should display ListView '
      'when state is TopicsLoaded',
      (tester) async {
        when(() => topicsBloc.state).thenReturn(const TopicsLoaded(topics));

        await tester.pumpWidget(
          MaterialApp(
            home: buildBlocProvider(
              child: const TopicsView(),
            ),
          ),
        );

        expect(find.byType(ListView), findsOneWidget);
      },
    );

    testWidgets(
      'should display TopicsEmptyView '
      'when state is TopicsLoadedEmpty',
      (tester) async {
        when(() => topicsBloc.state).thenReturn(const TopicsLoadedEmpty());

        await tester.pumpWidget(
          MaterialApp(
            home: buildBlocProvider(
              child: const TopicsView(),
            ),
          ),
        );

        expect(find.byType(TopicsEmptyView), findsOneWidget);
      },
    );

    testWidgets(
      'should display QuizzErrorView '
      'when state is TopicsLoadError',
      (tester) async {
        when(() => topicsBloc.state).thenReturn(const TopicsLoadError('Error'));

        await tester.pumpWidget(
          MaterialApp(
            home: buildBlocProvider(
              child: const TopicsView(),
            ),
          ),
        );

        expect(find.byType(QuizzErrorView), findsOneWidget);
      },
    );
  });
}
