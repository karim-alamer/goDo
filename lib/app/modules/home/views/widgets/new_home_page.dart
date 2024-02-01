import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_do/app/modules/home/controllers/home_controller.dart';
import 'package:go_do/app/routes/app_pages.dart';
import '../../../add_task_screen/views/add_task_screen_view.dart';
import 'no_data_widget.dart';

class HomePageBodyNew extends GetView<HomeController> {
  const HomePageBodyNew({Key? key}) : super(key: key);

  final List<Color> colorList = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (controller.filteredTaskList.isEmpty) {
        return const Center(
          child: NoDataWidget(),
        );
      } else {
        return ListView.builder(
          itemCount: controller.filteredTaskList.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Card(
            elevation: 3.0,
            color: Get.isDarkMode
                ? const Color(0xFF333333)
                : controller.filteredTaskList[index].taskColor,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(controller.filteredTaskList[index].title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${controller.filteredTaskList[index].starttime}:${controller.filteredTaskList[index].endtime}"),
                          Text(controller.filteredTaskList[index].note),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        Get.to(() => AddTaskScreenView(
                              task: controller.filteredTaskList[index],
                              id: controller.filteredTaskList[index].id,
                            ));
                      } else if (value == 'delete') {
                        //TODO alignment of the add , cancel
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              alignment: Alignment.centerLeft,
                              title: Text(
                                'title_delete_task'.tr,
                                style: const TextStyle(fontFamily: 'Cairo'),
                              ),
                              content: Text('content_delete_task'.tr),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    //Get.toNamed(Routes.HOME);
                                    Get.back();
                                  },
                                  child: Text('cancelpopup'.tr),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.deleteTask(
                                      controller.filteredTaskList[index].id,
                                    );
                                    Get.offAllNamed(Routes.HOME);
                                    // Get.toNamed(Routes.HOME);
                                    // Get.back();
                                  },
                                  child: Text('Okpopup'.tr),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Get.isDarkMode ? Colors.lightBlue : Colors.black,
                    ),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Edit Task'),
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete Task'),
                        ),
                      ),
                    ],
                  ),
                  Checkbox(
                    value: (controller.filteredTaskList[index].isCompleted == 1)
                        ? true
                        : false, // Provide the value of your checkbox here,
                    onChanged: (bool? value) {
                      controller.setTaskComplete(
                          value, controller.filteredTaskList[index].id);
                    },
                  ),
                ],
              ),
            ]),
          ),
        );
      }
    });
  }
}
