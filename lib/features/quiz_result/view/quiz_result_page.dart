import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quizz_app/features/quiz/models/answer_history.dart';
import 'package:quizz_app/features/quiz_result/widgets/answer_history_view.dart';
import 'package:quizz_app/theme/color_scheme.dart';
import 'package:quizz_app/theme/typography.dart';

class QuizResultPage extends StatelessWidget {
  static const routeName = 'quizResultPage';

  final List<AnswerHistory> quizResults;

  const QuizResultPage({
    Key? key,
    required this.quizResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: PieChart(
                  dataMap: {
                    "correct": quizResults.getCorrectAnswerCount().toDouble(),
                    "wrong": quizResults.getWrongAnswerCount().toDouble(),
                  },
                  colorList: [
                    Theme.of(context).colorScheme.green,
                    Theme.of(context).colorScheme.red
                  ],
                  centerText:
                      '${quizResults.getCorrectAnswerCount()} / ${quizResults.length}',
                  chartType: ChartType.ring,
                  legendOptions: const LegendOptions(showLegends: false),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValues: false,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  ElevatedButton(
                    child: const Text('Share your score'),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your Results',
                    style: Theme.of(context).textTheme.quizTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final answer = quizResults[index];

                  return AnswerHistoryView(answer: answer);
                },
                childCount: quizResults.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
