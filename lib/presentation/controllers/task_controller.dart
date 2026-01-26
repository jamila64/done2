import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/database_helper.dart';

class TaskController extends GetxController {
  var userName = "".obs;
  var userImage = "".obs;
  var tasks = <Map<String, dynamic>>[].obs;
  var isArabic = true.obs;
  var filterType = "all".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async {
    final db = await DatabaseHelper.instance.database;
    final user = await db.query('users', limit: 1);
    if (user.isNotEmpty) {
      userName.value = user.first['name'] as String;
      userImage.value = user.first['image'] as String? ?? "";
      loadTasks();
    }
  }

  void loadTasks() async {
    final db = await DatabaseHelper.instance.database;
    final data = await db.query('tasks');
    tasks.assignAll(data);
  }

  Future<void> signup(String name) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('users', {'name': name, 'image': userImage.value});
    userName.value = name;
    Get.offAllNamed('/home');
  }

  Future<void> pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) userImage.value = img.path;
  }

  Future<void> addTask(String title) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('tasks', {'title': title, 'isDone': 0, 'user_id': 1, 'cat_id': 1});
    loadTasks();
    Get.back();
  }

  void toggleTask(int id, int currentStatus) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('tasks', {'isDone': currentStatus == 1 ? 0 : 1}, where: 'id = ?', whereArgs: [id]);
    loadTasks();
  }

  void deleteTask(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    loadTasks();
  }

  void logout() async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('users');
    await db.delete('tasks');
    userName.value = "";
    Get.offAllNamed('/signup');
  }

  List<Map<String, dynamic>> get filteredTasks {
    if (filterType.value == "completed") return tasks.where((t) => t['isDone'] == 1).toList();
    if (filterType.value == "pending") return tasks.where((t) => t['isDone'] == 0).toList();
    return tasks;
  }
}