import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:go_do/app/modules/home/views/home_view.dart';
import 'package:go_do/services/notify_contoller.dart';

class NotifyHelperService {
  static final NotifyHelperService _instance = NotifyHelperService._internal();
  static NotifyHelperService get instance => _instance;
  // GetX controller instance
  final NotificationController _notificationController =
      Get.put(NotificationController());
  factory NotifyHelperService() {
    return _instance;
  }
  NotifyHelperService._internal();

  List<Map<String, dynamic>> get notificationList =>
      _notificationController.notificationList;

  Future<void> setup() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) {
        return Future.value(null);
      },
      onNotificationDisplayedMethod:
          (ReceivedNotification receivedNotification) {
        // Extract title and body from the displayed notification
        final title = receivedNotification.title ?? 'No Title';
        final body = receivedNotification.body ?? 'No Body';
        // Create a map with notification details
        final notificationData = {'title': title, 'body': body };
        _notificationController.addNotification(notificationData);
        return Future.value(null);
      },
    );
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic notifications',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
      debug: true,
    );
  }

  Future<void> navigateToNotificationPage() async {
    Get.to(() => NotificationPage());
  }

  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledTime) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.toUnsigned(32),
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar(
        weekday: scheduledTime.weekday,
        hour: scheduledTime.hour,
        minute: scheduledTime.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'navigate_to_notification_page',
          label: 'View Details',
        ),
      ],
    );
  }
}
