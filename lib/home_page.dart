import 'package:flutter/material.dart';
import 'my_drawer.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  final String userName;
  const HomePage({super.key, required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tasks = [
    {"title": "مراجعة محاضرة البرمجة", "level": 9.0, "isDone": false},
    {"title": "حل واجب الرياضيات", "level": 6.0, "isDone": true},
  ];
  String currentFilter = "all"; // المتغير المسؤول عن التصفية

  // دالة لجلب المهام بناءً على التصفية المختارة
  List<Map<String, dynamic>> get filteredTasks {
    if (currentFilter == "completed") {
      return tasks.where((t) => t['isDone'] == true).toList();
    } else if (currentFilter == "pending") {
      return tasks.where((t) => t['isDone'] == false).toList();
    }
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
            currentFilter == "all" ? "كل المهام" :
            currentFilter == "completed" ? "المهام المكتملة" : "المهام غير المكتملة",
            style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: MyDrawer(
        userName: widget.userName,
        onFilterChanged: (filter) {
          setState(() => currentFilter = filter);
        },
      ),
      body: filteredTasks.isEmpty
          ? const Center(child: Text("لا توجد مهام حاليا الإنجاز! "))
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          final task = filteredTasks[index];
          // نجد موقع العنصر الأصلي في القائمة الكبيرة لتحديثه بشكل صحيح
          final originalIndex = tasks.indexOf(task);

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  right: BorderSide(
                      color: task['isDone'] ? Colors.green : Colors.orange,
                      width: 8
                  ),
                ),
              ),
              child: ListTile(
                leading: Checkbox(
                  activeColor: Colors.green,
                  value: task['isDone'],
                  onChanged: (val) {
                    setState(() => tasks[originalIndex]['isDone'] = val);
                  },
                ),
                title: Text(
                  task['title'],
                  style: TextStyle(
                    decoration: task['isDone'] ? TextDecoration.lineThrough : null,
                    color: task['isDone'] ? Colors.grey : Colors.indigo[900],
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () => setState(() => tasks.removeAt(originalIndex)),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
          if (result != null) {
            setState(() => tasks.add(result));
          }
        },
        label: const Text("مهمة جديدة"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
    );
  }
}