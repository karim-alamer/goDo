import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_do/app/data/models/task.dart';
import 'package:go_do/app/modules/add_task_screen/views/widgets/task_form_widget.dart';
import 'package:sizer/sizer.dart';
import '../controllers/add_task_screen_controller.dart';

class AddTaskScreenView extends GetView<AddTaskScreenController> {
  final TaskModel? task;
  final int? id;
  const AddTaskScreenView({Key? key, this.task, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0.2.h, vertical: 0.1.h),
          child: TaskFormWidget(task: task, id: id),
        ),
      ),
    );
  }
}
