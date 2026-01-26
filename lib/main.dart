
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/controllers/task_controller.dart';
import 'core/translations.dart';
import 'presentation/pages/add_task_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/settings_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TaskController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslations(),
      locale: const Locale('ar'),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Splashscreen()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/settings', page: () => SettingsPage()),
        GetPage(name: '/add-task', page: () => AddTaskPage()),
      ],
    );
  }
}