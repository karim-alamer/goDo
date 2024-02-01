import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_do/app/modules/home/views/data_analysis.dart';

import 'package:go_do/app/modules/home/views/widgets/add_task_bar_widget.dart';
import 'package:go_do/app/modules/home/views/widgets/calendar_widget.dart';
import 'package:go_do/app/modules/home/views/widgets/new_home_page.dart';
import 'package:go_do/services/notify_service.dart';
import '../../../../services/notify_contoller.dart';
import '../../../../theme.dart';
import '../controllers/home_controller.dart';
import '../controllers/theme_controller.dart';
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
            icon: _buildNotificationIcon(),
            onPressed: () {
              NotifyHelperService().navigateToNotificationPage();
              Get.find<NotificationController>().chaneToUnready();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
                size: 25,
                color: Colors.grey,
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
        backgroundColor: Colors.lightBlue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const AddTaskBarWidget(),

          const AddCalendarWidget(),
          const HomePageBodyNew(),
          // HomeBodyWidget(),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Center(child: Text("GoDo")),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Analysis'),
              onTap: () {
                Get.to(() => const DataAnalysisPage());
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.language),
              title: const Text(' Language '),
              children: [
                ListTile(
                  title: const Text('Arabic'),
                  onTap: () async {
                    await Get.updateLocale(const Locale('ar'));
                    Get.delete();
                  },
                ),
                ListTile(
                  title: const Text('English'),
                  onTap: () async {
                    await Get.updateLocale(const Locale('en'));
                    Get.delete();
                  },
                ),
              ],
            ),
            ListTile(
              leading: Get.isDarkMode
                  ? const Icon(Icons.wb_sunny)
                  : const Icon(Icons.brightness_2),
              title: const Text(' Mode '),
              onTap: () async {
                if (Get.isDarkMode) {
                  Get.find<ThemeController>().changeTheme(AppTheme.light);
                } else {
                  Get.find<ThemeController>().changeTheme(AppTheme.dark);
                }
                Get.delete();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('App version'),
              onTap: () {
                Get.delete();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    final NotificationController notifyController =
        Get.find<NotificationController>();

    return Obx(
      () {
        int unreadNotificationCount = notifyController.notificationList.length;

        return Stack(
          children: [
            const Icon(
              Icons.notifications_active,
              size: 30,
              color: Colors.grey,
            ),
            if (unreadNotificationCount > 0 && notifyController.isread.value)
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '$unreadNotificationCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class NotificationPage extends StatelessWidget {
  final NotificationController notifyController =
      Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: notifyController.notificationList.length,
          itemBuilder: (context, index) {
            final notification = notifyController.notificationList[index];
            final title = notification['title'] ?? 'No Title';
            final body = notification['body'] ?? 'No Body';
            final unread = notification['unread'] ?? true;

            return ListTile(
              title: Text(title),
              subtitle: Text(body),
              tileColor: unread ? Colors.grey[200] : null,
              onTap: () {
                // Mark the notification as read when tapped
                notifyController.markAsRead(index);
              },
            );
          },
        ),
      ),
    );
  }
}
