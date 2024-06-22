import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            itemBuilder: (context, index) {
              final task = controller.filteredTaskList[index];
              Color tileColor;
              // Determine the tile color based on task properties
              if (task.isCompleted == 1) {
                tileColor =
                    const Color(0xFFCAF5BD); // Color for completed tasks
              } else if (DateTime.parse(task.date).isBefore(DateTime.now())) {
                tileColor = const Color(0xFFC2E7F0);
              } else {
                tileColor = const Color(0xFFF8E1D3);
              }

              return Card(
                color: tileColor,
                // color: Colors.white,
                // color: Get.isDarkMode
                //     ? const Color(0xFF333333)
                //     : controller.filteredTaskList[index].taskColor,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                  controller.filteredTaskList[index].title,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                        controller.filteredTaskList[index].note,
                                        style: const TextStyle(
                                            fontSize: 17, color: Colors.black)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "From: ${controller.filteredTaskList[index].starttime}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "To: ${controller.filteredTaskList[index].endtime}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          PopupMenuButton<String>(
                            color: Colors.white,
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
                                        style: const TextStyle(
                                            fontFamily: 'Cairo'),
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
                                              controller
                                                  .filteredTaskList[index].id,
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
                              color: Get.isDarkMode
                                  ? Colors.lightBlue
                                  : Colors.black,
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
                            value: (controller
                                        .filteredTaskList[index].isCompleted ==
                                    1)
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
              );
            });
      }
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_do/app/modules/home/controllers/home_controller.dart';
// import 'package:go_do/app/routes/app_pages.dart';
// import '../../../add_task_screen/views/add_task_screen_view.dart';
// import 'no_data_widget.dart';

// class HomePageBodyNew extends GetView<HomeController> {
//   const HomePageBodyNew({Key? key}) : super(key: key);

//   final List<Color> colorList = const [
//     Color(0xffDAD3C8),
//     Color(0xffFFE5DE),
//     Color(0xffDCF6E6),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//       if (controller.filteredTaskList.isEmpty) {
//         return const Center(
//           child: NoDataWidget(),
//         );
//       } else {
//         return GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(20),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//             childAspectRatio: 3 / 2,
//           ),
//           itemCount: controller.filteredTaskList.length,
//           itemBuilder: (context, index) {
//             final task = controller.filteredTaskList[index];
//             Color tileColor;

//             // Determine the tile color based on task properties
//             if (task.isCompleted == 1) {
//               tileColor = const Color(0xFFCAF5BD); // Color for completed tasks
//             } else if (DateTime.parse(task.date).isBefore(DateTime.now())) {
//               tileColor = const Color(0xFFC2E7F0);
//             } else {
//               tileColor = const Color(0xFFF8E1D3);
//             }

//             return Card(
//               color: tileColor,
//               margin: const EdgeInsets.all(0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ListTile(
//                     title: Text(
//                       task.title,
//                       style: const TextStyle(fontSize: 20, color: Colors.black),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Opacity(
//                           opacity: 0.5,
//                           child: Text(
//                             task.note,
//                             style: const TextStyle(
//                                 fontSize: 17, color: Colors.black),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "From: ${task.starttime}",
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w100,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             Text(
//                               "To: ${task.endtime}",
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w100,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   PopupMenuButton<String>(
//                     color: Colors.white,
//                     onSelected: (value) {
//                       if (value == 'edit') {
//                         Get.to(() => AddTaskScreenView(
//                               task: task,
//                               id: task.id,
//                             ));
//                       } else if (value == 'delete') {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               alignment: Alignment.centerLeft,
//                               title: Text(
//                                 'title_delete_task'.tr,
//                                 style: const TextStyle(fontFamily: 'Cairo'),
//                               ),
//                               content: Text('content_delete_task'.tr),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Get.back();
//                                   },
//                                   child: Text('cancelpopup'.tr),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     controller.deleteTask(task.id);
//                                     Get.offAllNamed(Routes.HOME);
//                                   },
//                                   child: Text('Okpopup'.tr),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     },
//                     icon: Icon(
//                       Icons.more_vert,
//                       color: Get.isDarkMode ? Colors.lightBlue : Colors.black,
//                     ),
//                     itemBuilder: (BuildContext context) =>
//                         <PopupMenuEntry<String>>[
//                       const PopupMenuItem<String>(
//                         value: 'edit',
//                         child: ListTile(
//                           leading: Icon(Icons.edit),
//                           title: Text('Edit Task'),
//                         ),
//                       ),
//                       const PopupMenuItem<String>(
//                         value: 'delete',
//                         child: ListTile(
//                           leading: Icon(Icons.delete),
//                           title: Text('Delete Task'),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Checkbox(
//                     value: (task.isCompleted == 1) ? true : false,
//                     onChanged: (bool? value) {
//                       controller.setTaskComplete(value, task.id);
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }
//     });
//   }
// }
