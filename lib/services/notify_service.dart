import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:go_do/app/modules/notification/controllers/notification_controller.dart';
import 'package:go_do/app/modules/notification/views/notification_view.dart';

class NotifyHelperService {
  static final NotifyHelperService _instance = NotifyHelperService._internal();
  static NotifyHelperService get instance => _instance;
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
        if (!_notificationController.isMuted.value) {
          final title = receivedNotification.title ?? 'No Title';
          final body = receivedNotification.body ?? 'No Body';
          final notificationData = {'title': title, 'body': body};
          _notificationController.addNotification(notificationData);
        }
        return Future.value(null);
      },
    );

    await AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      //null,
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
    Get.to(() => NotificationView());
  }

  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledTime) async {
    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (!_notificationController.isMuted.value) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'basic_channel',
          title: title,
          body: body,
          icon: 'resource://drawable/godo_logo',
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
    } else {
      // If muted, store the notification in the pending notification list
      _notificationController.addPendingNotification({
        'id': notificationId,
        'title': title,
        'body': body,
        'schedule': NotificationCalendar(
          weekday: scheduledTime.weekday,
          hour: scheduledTime.hour,
          minute: scheduledTime.minute,
          second: 0,
          millisecond: 0,
          repeats: true,
        ),
      });
    }
  }
}
