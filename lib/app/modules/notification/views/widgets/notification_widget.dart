import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_do/app/modules/notification/controllers/notification_controller.dart';

Widget buildNotificationIcon() {
  final NotificationController notifyController =
      Get.find<NotificationController>();

  return Obx(() {
    bool isMuted = notifyController.isMuted.value;
    return Icon(
      isMuted ? Icons.notifications_off : Icons.notifications_active,
      size: 30,
      color: const Color(0xFF202738),
    );
  });
}
