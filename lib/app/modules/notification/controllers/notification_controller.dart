// import 'package:get/get.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';

// class NotificationController extends GetxController {
//   RxList<Map<String, dynamic>> _notificationList = <Map<String, dynamic>>[].obs;
//   RxBool isread = true.obs;
//   RxBool isMuted = false.obs;
//   List<Map<String, dynamic>> _mutedNotificationList =
//       []; // Store muted notifications

//   RxList<Map<String, dynamic>> get notificationList => _notificationList;

//   void chaneToUnready() {
//     isread.value = false;
//   }

//   void addNotification(Map<String, dynamic> notification) {
//     _notificationList.add(notification);
//     isread.value = true;
//   }

//   void markAsRead(int index) {
//     _notificationList[index]['unread'] = false;
//   }

//   void removeNotification(Map<String, dynamic> notification) {
//     _notificationList.remove(notification);
//   }

//   void updateNotificationList(List<Map<String, dynamic>> newList) {
//     newList.forEach((notification) {
//       notification['unread'] = true;
//     });
//     _notificationList.assignAll(newList);
//   }

//   void toggleMute() {
//     isMuted.value = !isMuted.value;
//     if (isMuted.value) {
//       _muteAllNotifications();
//     } else {
//       _unmuteAllNotifications();
//     }
//   }

//   void _muteAllNotifications() {
//     // Cancel all scheduled notifications and store them in _mutedNotificationList
//     AwesomeNotifications().cancelAll();
//     _mutedNotificationList = List.from(_notificationList);
//   }

//   void _unmuteAllNotifications() {
//     // Reschedule notifications from _mutedNotificationList
//     for (var notification in _mutedNotificationList) {
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
//           channelKey: 'basic_channel',
//           title: notification['title'],
//           body: notification['body'],
//         ),
//       );
//     }
//     _mutedNotificationList.clear();
//   }
// }
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationController extends GetxController {
  RxList<Map<String, dynamic>> _notificationList = <Map<String, dynamic>>[].obs;
  RxBool isread = true.obs;
  RxBool isMuted = false.obs; 
  List<Map<String, dynamic>> _mutedNotificationList = []; // Store muted notifications
  List<Map<String, dynamic>> _pendingNotificationList = []; // Store notifications to be sent later

  RxList<Map<String, dynamic>> get notificationList => _notificationList;
  List<Map<String, dynamic>> get mutedNotificationList => _mutedNotificationList; // Add getter

  void chaneToUnready() {
    isread.value = false;
  }

  void addNotification(Map<String, dynamic> notification) {
    _notificationList.add(notification);
    isread.value = true;
  }

  void markAsRead(int index) {
    _notificationList[index]['unread'] = false;
  }

  void removeNotification(Map<String, dynamic> notification) {
    _notificationList.remove(notification);
  }

  void updateNotificationList(List<Map<String, dynamic>> newList) {
    newList.forEach((notification) {
      notification['unread'] = true;
    });
    _notificationList.assignAll(newList);
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
    if (isMuted.value) {
      _muteAllNotifications();
    } else {
      _unmuteAllNotifications();
    }
  }

  void _muteAllNotifications() {
    // Cancel all scheduled notifications and store them in _mutedNotificationList
    AwesomeNotifications().cancelAll();
    _mutedNotificationList = List.from(_notificationList);
  }

  void _unmuteAllNotifications() {
    // Reschedule notifications from _mutedNotificationList
    for (var notification in _mutedNotificationList) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          channelKey: 'basic_channel',
          title: notification['title'],
          body: notification['body'],
        ),
      );
    }
    _mutedNotificationList.clear();
    
    // Send pending notifications
    for (var notification in _pendingNotificationList) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notification['id'],
          channelKey: 'basic_channel',
          title: notification['title'],
          body: notification['body'],
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: notification['schedule'],
      );
    }
    _pendingNotificationList.clear();
  }

  void addMutedNotification(Map<String, dynamic> notification) {
    _mutedNotificationList.add(notification);
  }

  void addPendingNotification(Map<String, dynamic> notification) {
    _pendingNotificationList.add(notification);
  }
}
