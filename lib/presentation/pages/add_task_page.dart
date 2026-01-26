import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _taskC = TextEditingController();
    final TaskController c = Get.find();

    return Scaffold(
      appBar: AppBar(title: Text('add_task'.tr), backgroundColor: Colors.indigo, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _taskC,
              decoration: InputDecoration(
                hintText: 'add_task'.tr,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                if (_taskC.text.isNotEmpty) c.addTask(_taskC.text);
              },
              child: Text('save'.tr, style: const TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}