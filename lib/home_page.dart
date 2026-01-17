import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';
import 'my_drawer.dart';

class HomePage extends StatelessWidget {
  final TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Directionality(
      textDirection: controller.isArabic.value ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.isArabic.value ? "مهام ${controller.userName.value}" : "${controller.userName.value}'s Tasks"),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        drawer: const MyDrawer(),
        body: Obx(() => ListView.builder(
          itemCount: controller.filteredTasks.length,
          itemBuilder: (context, index) {
            var task = controller.filteredTasks[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(border: Border(right: BorderSide(color: task['isDone'] ? Colors.green : Colors.orange, width: 8))),
                child: ListTile(
                  leading: Checkbox(value: task['isDone'], onChanged: (v) => controller.toggleTask(index)),
                  title: Text(task['title'], style: TextStyle(decoration: task['isDone'] ? TextDecoration.lineThrough : null)),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => controller.deleteTask(index)),
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