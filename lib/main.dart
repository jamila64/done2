import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';
import 'splash_screen.dart'; // تأكد من استيرادها
import 'signup_page.dart';
import 'home_page.dart';
import 'settings_page.dart';
import 'add_task_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ضروري لاستخدام الذاكرة قبل runApp
  Get.put(TaskController()); // تشغيل المتحكم
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      // نقطة البداية هي شاشة Splash
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Splashscreen()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/settings', page: () => SettingsPage()),
        GetPage(name: '/add-task', page: () => const AddTaskPage()),
      ],
      // دعم اللغات
      locale: const Locale('ar'),
      fallbackLocale: const Locale('en'),
    );
  }
}