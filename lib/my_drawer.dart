import 'dart:io';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final String userName;
  final Function(String) onFilterChanged; // دالة لإرسال نوع التصفية للصفحة الرئيسية

  const MyDrawer({super.key, required this.userName, required this.onFilterChanged});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  File? _image;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            color: Colors.indigo,
            child: Column(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null ? const Icon(Icons.camera_alt, color: Colors.indigo, size: 30) : null,
                  ),
                ),
                const SizedBox(height: 15),
                Text(widget.userName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list, color: Colors.indigo),
            title: const Text("كل المهام"),
            onTap: () {
              widget.onFilterChanged("all");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.pending_actions, color: Colors.orange),
            title: const Text("المهام غير المكتملة"),
            onTap: () {
              widget.onFilterChanged("pending");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.task_alt, color: Colors.green),
            title: const Text("المهام المكتملة"),
            onTap: () {
              widget.onFilterChanged("completed");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}