import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_do/app/data/models/task.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controllers/analysis_controller.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisView extends GetView<AnalysisController> {
  const AnalysisView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('TaskModel.categories: ${TaskModel.categories}');
    print(
        'categoryCompletionPercentages: ${controller.categoryCompletionPercentages}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          if (controller.categoryCompletionPercentages.isEmpty) {
            return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
          } else {
            double weekCompletionPercentage =
                controller.weekCompletionPercentage.value;
            double monthCompletionPercentage =
                controller.monthCompletionPercentage.value;
            double yearCompletionPercentage =
                controller.yearCompletionPercentage.value;
            Map<String, double> categoryCompletionPercentages =
                controller.categoryCompletionPercentages;
            List<String> categories = controller.categories;
            print(
                'Category Completion PercentagesFFFFFFFFFFFFFFF: $categoryCompletionPercentages');

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your completed Tasks This Week',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 10.0,
                    percent: weekCompletionPercentage / 100,
                    center: Text(
                      '${weekCompletionPercentage.toStringAsFixed(1)}%',
                      style: const TextStyle(fontSize: 20),
                    ),
                    progressColor: Colors.blue,
                    backgroundColor: Colors.grey.shade200,
                    circularStrokeCap: CircularStrokeCap.round,
                    footer: const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('Your completed Tasks This Month'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 10.0,
                    percent: monthCompletionPercentage / 100,
                    center: Text(
                      '${monthCompletionPercentage.toStringAsFixed(1)}%',
                      style: const TextStyle(fontSize: 20),
                    ),
                    progressColor: Colors.green,
                    backgroundColor: Colors.grey.shade200,
                    circularStrokeCap: CircularStrokeCap.round,
                    footer: const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('Your completed Tasks This Year'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 10.0,
                    percent: yearCompletionPercentage / 100,
                    center: Text(
                      '${yearCompletionPercentage.toStringAsFixed(1)}%',
                      style: const TextStyle(fontSize: 20),
                    ),
                    progressColor: Colors.red,
                    backgroundColor: Colors.grey.shade200,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Category Completion Percentages',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                        barGroups: List.generate(
                          categories.length,
                          (index) {
                            // String category = TaskModel.categories[index];
                            // double completionPercentage =
                            //     categoryCompletionPercentages[category] ?? 0;
                            // print(
                            //     'Category: $category, Completion: $completionPercentage');
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  // Access categoryCompletionPercentages through the controller
                                  toY: categoryCompletionPercentages[
                                          categories[index]] ??
                                      0,
                                  width: 20,
                                  color: Colors.blue,
                                ),
                              ],
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 20,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() >= 0 &&
                                    value.toInt() < categories.length) {
                                  return Text(categories[value.toInt()]);
                                }
                                return Text('${value.toInt()}%');
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() >= 0 &&
                                    value.toInt() <
                                        TaskModel.categories.length) {
                                  return Text(
                                      TaskModel.categories[value.toInt()]);
                                }
                                return Text('');
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barTouchData: BarTouchData(enabled: true),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
