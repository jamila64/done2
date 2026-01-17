import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => GestureDetector(
              onTap: () => taskController.pickImage(),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.indigo[100],
                backgroundImage: taskController.userImage.value.isNotEmpty
                    ? FileImage(File(taskController.userImage.value)) : null,
                child: taskController.userImage.value.isEmpty
                    ? const Icon(Icons.camera_alt, size: 40, color: Colors.indigo) : null,
              ),
            )),
            const SizedBox(height: 30),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "اسم المستخدم",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.indigo,
              ),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  taskController.saveUser(_controller.text);
                  Get.offAllNamed('/home');
                }
              },
              child: const Text("دخول", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}