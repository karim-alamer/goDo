import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_do/app/modules/home/controllers/home_controller.dart';

class AddCalendarWidget extends GetView<HomeController> {
  const AddCalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //remove the currentlocale from there
    Locale currentLocale = Get.locale ?? const Locale('en', 'US');
    final datePickerController = DatePickerController();
    DateTime selectedDate = DateTime.now();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container(
          margin: const EdgeInsets.only(top: 20, left: 20),
          child: DatePicker(
            DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: const Color(0xFF22385C),
            selectedTextColor: Colors.white,
            dateTextStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            dayTextStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            monthTextStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            controller: datePickerController,
            onDateChange: (date) {
              print("//////>>>>>>>>>>>>>>>>>>>>>////");
              selectedDate = date;
              controller
                  .getAllTasks(); // Use the controller to call setSelectedDate
            },
            locale: currentLocale.languageCode,
          ),
        );
      }
    });
  }
}
