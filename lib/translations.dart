import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar': {
      'app_title': 'مهامي الدراسية',
      'add_task': 'إضافة مهمة دراسية',
      'task_title': 'عنوان المهمة',
      'save': 'حفظ المهمة',
      'settings': 'الإعدادات',
      'lang': 'لغة التطبيق',
      'logout': 'تسجيل الخروج',
      'no_tasks': 'لا توجد مهام حالياً',
    },
    'en': {
      'app_title': 'My Study Tasks',
      'add_task': 'Add Study Task',
      'task_title': 'Task Title',
      'save': 'Save Task',
      'settings': 'Settings',
      'lang': 'App Language',
      'logout': 'Logout',
      'no_tasks': 'No tasks currently',
    }
  };
}