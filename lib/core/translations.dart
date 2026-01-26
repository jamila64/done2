import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar': {
      'app_title': 'مُنجز المهام',
      'login': 'تسجيل الدخول',
      'name_hint': 'أدخل اسمك',
      'home': 'الرئيسية',
      'settings': 'الإعدادات',
      'add_task': 'إضافة مهمة',
      'logout': 'خروج',
      'pending': 'قيد الإنجاز',
      'completed': 'مكتملة',
      'save': 'حفظ التغييرات',
    },
    'en': {
      'app_title': 'Task Master',
      'login': 'Sign In',
      'name_hint': 'Enter your name',
      'home': 'Home',
      'settings': 'Settings',
      'add_task': 'Add Task',
      'logout': 'Logout',
      'pending': 'Pending',
      'completed': 'Completed',
      'save': 'Save Changes',
    }
  };
}