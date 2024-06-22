import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationController notifyController =
        Get.find<NotificationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
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
