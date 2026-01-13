import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  double _level = 5.0;
  final _cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إضافة مهمة")),
      body: Column(
        children: [
          TextField(controller: _cont, decoration: const InputDecoration(labelText: "عنوان المهمة")),
          Slider(value: _level, min: 1, max: 10, divisions: 9, onChanged: (v) => setState(() => _level = v)),
          Text("الأهمية: ${_level.toInt()}"),
          ElevatedButton(onPressed: () => Navigator.pop(context, {"title": _cont.text, "level": _level, "isDone": false}), child: const Text("حفظ")),
        ],
      ),
    );
  }
}