import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/add_task_screen_controller.dart';

class AddTaskScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTaskScreenController>(
      () => AddTaskScreenController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
