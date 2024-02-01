import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';

import 'package:go_do/app/data/models/task.dart';
import 'package:go_do/repositry/task_db.dart';
import 'package:go_do/services/notify_service.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  getx.RxList<TaskModel> statictaskList = <TaskModel>[].obs;
  getx.Rx<DateTime> selectedDate = DateTime.now().obs;
  getx.RxList<TaskModel> filteredTaskList = <TaskModel>[].obs;
  getx.RxBool isLoading = true.obs;
  Future<void> requestNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  Future<void> getAllTasks() async {
    List<Map<String, dynamic>> taskData = await SQLHelper().queryAllTasks();
    filteredTaskList.assignAll(
      taskData.map((task) => TaskModel.fromMap(task)).toList(),
    );
    isLoading.value = false;
  }

  // Function to update the selected date and filter tasks
  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
    getTasksByDate(date);
    update();
  }

  addTask(TaskModel task) async {
    await SQLHelper().insertTask(task);
    statictaskList.add(task);
    getAllTasks();
  }

  deleteTask(int? id) async {
    await SQLHelper().delete(id!);
    getAllTasks();
  }

  upateItem(TaskModel task, int? id) async {
    await SQLHelper().update(task, id);
    getAllTasks();
  }

  setTaskComplete(bool? value, int? id) async {
    await SQLHelper().updateTaskComplete(value, id);
    getAllTasks();
  }

  Future<void> handleNotificationPermissionChange(bool granted) async {
    if (granted) {
      // Do something when notification permission is granted
    } else {
      // Do something when notification permission is not granted
    }
  }

  // Function to filter tasks by date
  Future<void> getTasksByDate([DateTime? date]) async {
    if (date == null) {
      print("i am heeeeeeeeeeeeeeeeeeeeeeeeeeeeeer");
      await getAllTasks();
      filteredTaskList.forEach((task) {
        DateTime taskDate = DateTime.parse(task.date);
        DateTime currentDate = DateTime.now();

        if (taskDate.isBefore(currentDate)) {
          task.taskColor = Colors.lightBlue;
        } else if (taskDate.year == currentDate.year &&
            taskDate.month == currentDate.month &&
            taskDate.day == currentDate.day) {
          task.taskColor = Colors.white;
        } else {
          task.taskColor = const Color.fromARGB(
              255, 226, 225, 225); // Use your existing color logic
        }
      });
    } else {
      selectedDate.value = date;
      await getAllTasks();
      final filter_data = filteredTaskList.where((task) {
        // Convert the task date (String) to DateTime
        DateTime taskDate = DateTime.parse(task.date);

        return taskDate.year == selectedDate.value.year &&
            taskDate.month == selectedDate.value.month &&
            taskDate.day == selectedDate.value.day;
      }).toList();
      filter_data.forEach((task) {
        DateTime taskDate = DateTime.parse(task.date);
        DateTime currentDate = DateTime.now();

        if (taskDate.isBefore(currentDate)) {
          task.taskColor = Colors.blue;
        } else if (taskDate.year == currentDate.year &&
            taskDate.month == currentDate.month &&
            taskDate.day == currentDate.day) {
          task.taskColor = Colors.red;
        } else {
          task.taskColor = Colors.white; // Use your existing color logic
        }
      });
      filteredTaskList.assignAll(filter_data);
      isLoading.value = false;
    }
  }

  addOrUpdateTask({
    required BuildContext context,
    required TextEditingController titleController,
    required TextEditingController noteController,
    required DateTime currentDate,
    required TimeOfDay startHour,
    required TimeOfDay endHour,
    required int selectedReminder,
    required int selectedColor,
    required bool isEditMode,
    required int? taskId,
  }) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(
                'Add a New task',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              content: const Text('do you want to add a new task?'),
              actions: [
                TextButton(
                  onPressed: () async {
                    TaskModel task = TaskModel(
                        title: titleController.text,
                        note: noteController.text,
                        date: DateFormat('yyyy-MM-dd').format(currentDate),
                        starttime: startHour.format(context),
                        endtime: endHour.format(context),
                        reminder: selectedReminder,
                        colorindex: selectedColor,
                        repeat: "all day",
                        isCompleted: 0);
                    if (isEditMode) {
                      await upateItem(task, taskId);
                    } else {
                      await addTask(task);
                    }
                    final DateTime taskStartTime = DateTime(
                        currentDate.year,
                        currentDate.month,
                        currentDate.day,
                        startHour.hour,
                        startHour.minute);
                    final DateTime notifacationTime = taskStartTime
                        .subtract(Duration(minutes: selectedReminder));
                    //format the notifacation messae
                    final String notifacationTitle = titleController.text;
                    final String notifacationBody = noteController.text;
                    NotifyHelperService().scheduleNotification(
                        notifacationTitle, notifacationBody, notifacationTime);
                    Get.offAllNamed(Routes.HOME);

                    // Get.offAll(const HomeView());
                  },
                  child: Text('Okpopup'.tr),
                ),
                TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('cancelpopup'.tr),
              ),
              ]);
        });
  }

  @override
  void onInit() {
    super.onInit();
    requestNotificationPermission();
    getTasksByDate();
  }

  @override
  void onClose() {
    print("Controller disposed");
    super.onClose();
  }
}
