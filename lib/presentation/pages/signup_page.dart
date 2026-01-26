import 'dart:io';                       // سيعرف 'File' ويحل المشكلة التي واجهتك سابقاً
import 'package:flutter/material.dart'; // سيعرف TextField, Padding, Button
import 'package:get/get.dart';         // سيعرف Obx و .tr (الترجمة)
import '../controllers/task_controller.dart'; // سيعرف المتحكم

class SignupPage extends StatelessWidget {
  final TextEditingController _nameC = TextEditingController();
  final TaskController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => GestureDetector(
              onTap: c.pickImage,
              child: CircleAvatar(radius: 50, backgroundImage: c.userImage.value.isNotEmpty ? FileImage(File(c.userImage.value))
                  : null, child: c.userImage.value.isEmpty ? Icon(Icons.camera_alt) : null),
            )),
            TextField(controller: _nameC, decoration: InputDecoration(labelText: 'name_hint'.tr)),
            ElevatedButton(onPressed: () => c.signup(_nameC.text), child: Text('login'.tr))
          ],
        ),
      ),
    );
  }
}