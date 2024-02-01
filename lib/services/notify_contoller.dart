import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<Map<String, dynamic>> _notificationList = <Map<String, dynamic>>[].obs;
  RxBool isread = true.obs;
  RxList<Map<String, dynamic>> get notificationList => _notificationList;
  void chaneToUnready() {
    isread.value = false;
  }

  // Function to add a notification to the list
  void addNotification(Map<String, dynamic> notification) {
    _notificationList.add(notification);
    //TODO handle
    isread.value = true;
  }

  void markAsRead(int index) {
    // Mark the notification as read
    _notificationList[index]['unread'] = false;
  }

  // Function to remove a notification from the list
  void removeNotification(Map<String, dynamic> notification) {
    _notificationList.remove(notification);
  }

  // Function to update the notification list
  void updateNotificationList(List<Map<String, dynamic>> newList) {
    newList.forEach((notification) {
      notification['unread'] = true; // Add 'unread' flag for new notifications
    });
    _notificationList.assignAll(newList);
  }
}
