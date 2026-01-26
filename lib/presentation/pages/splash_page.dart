import 'package:flutter/material.dart'; // سيعرف Scaffold, Colors, Icons
import 'package:get/get.dart';         // سيعرف Get
import '../../presentation/controllers/task_controller.dart'; // سيعرف المتحكم

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      final TaskController c = Get.find();
      Get.offAllNamed(c.userName.value.isEmpty ? '/signup' : '/home');
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(child: Icon(Icons.task_alt, size: 100, color: Colors.white)),
    );
  }
}