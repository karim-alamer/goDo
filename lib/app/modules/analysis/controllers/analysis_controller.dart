import 'package:get/get.dart';
import 'package:go_do/app/data/models/task.dart';
import 'package:go_do/repositry/task_db.dart';

class AnalysisController extends GetxController {
  final SQLHelper sqlHelper = SQLHelper();

  var totalTasks = 0.obs;
  var completedTasks = 0.obs;
  var weekCompletionPercentage = 0.0.obs;
  var monthCompletionPercentage = 0.0.obs;
  var yearCompletionPercentage = 0.0.obs;
  var categoryCompletionPercentages = <String, double>{}.obs;
  var categories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    List<Map<String, dynamic>> tasks = await sqlHelper.queryAllTasks();
    List<TaskModel> taskList =
        tasks.map((task) => TaskModel.fromMap(task)).toList();

    totalTasks.value = taskList.length;
    completedTasks.value =
        taskList.where((task) => task.isCompleted == 1).length;

    weekCompletionPercentage.value =
        calculateCompletionPercentage(taskList, 'week');
    monthCompletionPercentage.value =
        calculateCompletionPercentage(taskList, 'month');
    yearCompletionPercentage.value =
        calculateCompletionPercentage(taskList, 'year');
    categories.value =
        TaskModel.categories.map((cat) => cat.toLowerCase()).toList();

    calculateCategoryCompletionPercentages(taskList);
    print(
        'Category Completion PercentagesLLLLLLLL: $categoryCompletionPercentages');
  }

  double calculateCompletionPercentage(List<TaskModel> tasks, String period) {
    DateTime now = DateTime.now();
    List<TaskModel> filteredTasks;
    switch (period) {
      case 'week':
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        filteredTasks = tasks
            .where((task) => DateTime.parse(task.date).isAfter(startOfWeek))
            .toList();
        break;
      case 'month':
        DateTime startOfMonth = DateTime(now.year, now.month, 1);
        filteredTasks = tasks
            .where((task) => DateTime.parse(task.date).isAfter(startOfMonth))
            .toList();
        break;
      case 'year':
        DateTime startOfYear = DateTime(now.year, 1, 1);
        filteredTasks = tasks
            .where((task) => DateTime.parse(task.date).isAfter(startOfYear))
            .toList();
        break;
      default:
        return 0.0;
    }

    if (filteredTasks.isEmpty) return 0.0;

    int completedTasks =
        filteredTasks.where((task) => task.isCompleted == 1).length;
    return (completedTasks / filteredTasks.length) * 100;
  }

  void calculateCategoryCompletionPercentages(List<TaskModel> tasks) {
    Map<String, int> totalTasksByCategory = {};
    Map<String, int> completedTasksByCategory = {};

    for (var task in tasks) {
      totalTasksByCategory[task.category] =
          (totalTasksByCategory[task.category] ?? 0) + 1;
      if (task.isCompleted == 1) {
        completedTasksByCategory[task.category] =
            (completedTasksByCategory[task.category] ?? 0) + 1;
      }
    }

    categoryCompletionPercentages.clear();
    totalTasksByCategory.forEach((category, total) {
      int completed = completedTasksByCategory[category] ?? 0;
      categoryCompletionPercentages[category] = (completed / total) * 100;
      print(
          'Category000: $category, Completion000: ${categoryCompletionPercentages[category]}');
    });
  }
}
