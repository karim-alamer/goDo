import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_do/app/modules/home/views/widgets/add_task_bar_widget.dart';
import 'package:go_do/app/modules/home/views/widgets/calendar_widget.dart';
import 'package:go_do/app/modules/home/views/widgets/drawable.dart';
import 'package:go_do/app/modules/home/views/widgets/new_home_page.dart';
import 'package:go_do/app/modules/notification/controllers/notification_controller.dart';
import 'package:go_do/app/modules/notification/views/widgets/notification_widget.dart';
import '../controllers/home_controller.dart';
import 'package:go_do/app/modules/add_task_screen/views/add_task_screen_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          backgroundColor: context.theme.colorScheme.background,
          leading: IconButton(
            icon: buildNotificationIcon(),
            onPressed: () async {
              final NotificationController notifyController =
                  Get.find<NotificationController>();
              bool isMuted = notifyController.isMuted.value;

              bool? result = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(isMuted
                        ? 'UnmuteNotifications'.tr
                        : 'MuteNotifications'.tr),
                    content: Text(isMuted
                        ? 'unmuteallnotifications'.tr
                        : 'muteallnotifications'.tr),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'.tr),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Yes'.tr),
                      ),
                    ],
                  );
                },
              );

              if (result == true) {
                notifyController.toggleMute();
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.filter_list,
                size: 25,
                color: Color(0xFF202738),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.menu,
                size: 25,
                color: Color(0xFF202738),
              ),
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddTaskScreenView()),
        backgroundColor: const Color(0xFF223A56),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: const [
          AddTaskBarWidget(),
          AddCalendarWidget(),
          HomePageBodyNew(),
          Padding(padding: EdgeInsets.only(bottom: 80)),
        ],
      ),
      endDrawer: CustomDrawer(),
    );
  }
}
