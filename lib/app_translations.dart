import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'title': 'TODO',
          'addTask': 'Add Task',
          'tasks': 'Tasks',
          'title_delete_task': 'Delete Task',
          'content_delete_task': 'Do you want to delete this task?',
          'ThereIsNoTasks': 'There Is No Tasks',
          'cancelpopup' : 'Cancel',
          'Okpopup' : 'Ok'
        },
        'ar_AR': {
          "title": "تطبيق المهام",
          'title_delete_task': 'حذف المهمة',
          'content_delete_task': 'هل تريد حذف هذه المهمة؟',
          "addTask": "إضافة مهمة",
          "tasks": "المهام",
          'ThereIsNoTasks': 'لا توجد مهام حتي الان',
          'cancelpopup' : 'الغاء',
          'Okpopup' : 'موافق'
        }
      };
}
