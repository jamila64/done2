import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../pages//my_drawer.dart';
import 'dart:io';

class HomePage extends StatelessWidget {
  final TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Directionality(
      textDirection: controller.isArabic.value ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text('app_title'.tr),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundImage: controller.userImage.value.isNotEmpty
                    ? FileImage(File(controller.userImage.value)) : null,
                child: controller.userImage.value.isEmpty ? const Icon(Icons.person) : null,
              ),
            )
          ],
        ),
        drawer: const MyDrawer(),
        body: Obx(() => ListView.builder(
          itemCount: controller.filteredTasks.length,
          itemBuilder: (context, index) {
            var task = controller.filteredTasks[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                    right: controller.isArabic.value
                        ? BorderSide(color: task['isDone'] == 1 ? Colors.green : Colors.orange, width: 8)
                        : BorderSide.none,
                    left: !controller.isArabic.value
                        ? BorderSide(color: task['isDone'] == 1 ? Colors.green : Colors.orange, width: 8)
                        : BorderSide.none,
                  ),
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: task['isDone'] == 1,
                    onChanged: (val) => controller.toggleTask(task['id'], task['isDone']),
                  ),
                  title: Text(task['title'],
                    style: TextStyle(
                        decoration: task['isDone'] == 1 ? TextDecoration.lineThrough : null,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => controller.deleteTask(task['id']),
                  ),
                ),
              ),
            );
          },
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed('/add-task'),
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    ));
  }
}