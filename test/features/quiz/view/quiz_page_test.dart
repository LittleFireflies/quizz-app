import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quizz_app/core/shared_widgets/quizz_error_view.dart';
import 'package:quizz_app/features/quiz/bloc/setup_quiz/setup_quiz_bloc.dart';
import 'package:quizz_app/features/quiz/view/quiz_page.dart';

class MockSetupQuizBloc extends MockBloc<SetupQuizEvent, SetupQuizState>
    implements SetupQuizBloc {}

void main() {
  group('QuizPage', () {
    late SetupQuizBloc setupQuizBloc;

    setUp(() {
      setupQuizBloc = MockSetupQuizBloc();
    });

    Widget buildBlocProvider({required Widget child}) {
      return BlocProvider.value(
        value: setupQuizBloc,
        child: child,
      );
    }

    testWidgets(
      'should display error view '
      'when state is QuizLoadError',
      (tester) async {
        when(() => setupQuizBloc.state)
            .thenReturn(const QuizLoadError('Error!'));

        await tester.pumpWidget(
          MaterialApp(
            home: buildBlocProvider(
              child: const QuizView(),
            ),
          ),
        );

        expect(find.byType(QuizzErrorView), findsOneWidget);
      },
    );

    testWidgets(
      'should display loading view '
      'when state is QuizLoading',
      (tester) async {
        when(() => setupQuizBloc.state).thenReturn(const QuizLoading());

        await tester.pumpWidget(
          MaterialApp(
            home: buildBlocProvider(
              child: const QuizView(),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );
  });
}
