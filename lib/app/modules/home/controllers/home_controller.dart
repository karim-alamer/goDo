import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:go_do/app/data/models/task.dart';
import 'package:go_do/repositry/task_db.dart';
import 'package:go_do/services/notify_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  RxList<TaskModel> statictaskList = <TaskModel>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxList<TaskModel> filteredTaskList = <TaskModel>[].obs;
  RxBool isLoading = true.obs;
  RxString appVersion = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _fetchAppVersion();
    await requestNotificationPermission();
    await getAllTasks();
  }

  Future<void> requestNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  Future<void> getAllTasks() async {
    List<Map<String, dynamic>> taskData = await SQLHelper().queryAllTasks();
    List<TaskModel> tasks =
        taskData.map((task) => TaskModel.fromMap(task)).toList();

    DateTime parseDateTime(String date, String time) {
      // Convert 12-hour format with AM/PM to 24-hour format
      final DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm a');
      return dateFormat.parse('$date $time');
    }

    // Sort the tasks
    tasks.sort((a, b) {
      DateTime aDateTime = parseDateTime(a.date, a.starttime);
      DateTime bDateTime = parseDateTime(b.date, b.starttime);
      if (a.isCompleted == 1 && b.isCompleted != 1) {
        return 1; // Move completed tasks to the end
      } else if (a.isCompleted != 1 && b.isCompleted == 1) {
        return -1;
      }
      return aDateTime.compareTo(bDateTime);
    });

    filteredTaskList.assignAll(tasks);
    isLoading.value = false;
  }

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

  Future<void> getTasksByDate([DateTime? date]) async {
    if (date == null) {
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
          task.taskColor = const Color.fromARGB(255, 226, 225, 225);
        }
      });
    } else {
      selectedDate.value = date;
      await getAllTasks();
      final filter_data = filteredTaskList.where((task) {
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
          task.taskColor = Colors.white;
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
    required String selectedCategory,
    required bool isEditMode,
    required int? taskId,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'AddaNewtask'.tr,
            style: const TextStyle(fontFamily: 'Cairo'),
          ),
          content: Text('doyouwanttoaddanewtask?'.tr),
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
                  isCompleted: 0,
                  category: selectedCategory,
                );
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
                  startHour.minute,
                );
                final DateTime notifacationTime = taskStartTime.subtract(
                  Duration(minutes: selectedReminder),
                );
                final String notifacationTitle = titleController.text;
                final String notifacationBody = noteController.text;
                NotifyHelperService().scheduleNotification(
                  notifacationTitle,
                  notifacationBody,
                  notifacationTime,
                );
                Get.offAllNamed(Routes.HOME);
              },
              child: Text('Okpopup'.tr),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('cancelpopup'.tr),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
  }

  @override
  void onClose() {
    print("Controller disposed");
    super.onClose();
  }
}
