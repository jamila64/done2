import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart'; // تأكد من إضافة المكتبة
import 'dart:io';
import 'dart:convert';

class TaskController extends GetxController {
  var userName = "".obs;
  var userImage = "".obs;
  var tasks = <Map<String, dynamic>>[].obs;
  var isArabic = true.obs;
  var filterType = "all".obs;

  @override
  void onInit() {
    super.onInit();
    loadData(); // جلب البيانات عند فتح التطبيق
  }

  // --- دالة التقاط الصورة التي كانت مفقودة ---
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      userImage.value = image.path;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userImage', image.path);
    }
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('userName') ?? "";
    userImage.value = prefs.getString('userImage') ?? "";
    String? storedTasks = prefs.getString('tasks');
    if (storedTasks != null) {
      Iterable decoded = jsonDecode(storedTasks);
      tasks.assignAll(decoded.map((item) => Map<String, dynamic>.from(item)).toList());
    }
  }

  void saveUser(String name) async {
    userName.value = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
  }

  void addTask(String title, double level) {
    tasks.add({"title": title, "level": level, "isDone": false});
    _saveTasks();
  }

  void toggleTask(int index) {
    tasks[index]['isDone'] = !tasks[index]['isDone'];
    tasks.refresh();
    _saveTasks();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    _saveTasks();
  }

  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', jsonEncode(tasks));
  }

  List<Map<String, dynamic>> get filteredTasks {
    if (filterType.value == "completed") return tasks.where((t) => t['isDone']).toList();
    if (filterType.value == "pending") return tasks.where((t) => !t['isDone']).toList();
    return tasks;
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    userName.value = "";
    userImage.value = "";
    tasks.clear();
    Get.offAllNamed('/signup');
  }
}