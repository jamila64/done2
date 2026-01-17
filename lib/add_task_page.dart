import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart'; // استيراد المتحكم لإرسال البيانات إليه

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  // تعريف المتحكم للوصول لدالة addTask
  final TaskController controller = Get.find();

  final TextEditingController _titleController = TextEditingController();
  double _importanceLevel = 5.0; // القيمة الافتراضية للسلايدر

  @override
  Widget build(BuildContext context) {
    bool isArabic = controller.isArabic.value;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isArabic ? "إضافة مهمة دراسية" : "Add Study Task"),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(isArabic ? "عنوان المهمة:" : "Task Title:",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: isArabic ? "مثلاً: مذاكرة رياضيات" : "e.g. Math Study",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 30),
              Text(isArabic ? "مستوى الأهمية: ${_importanceLevel.toInt()}" : "Importance Level: ${_importanceLevel.toInt()}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              // السلايدر لتحديد الأهمية
              Slider(
                value: _importanceLevel,
                min: 1,
                max: 10,
                divisions: 9,
                activeColor: Colors.indigo,
                label: _importanceLevel.toInt().toString(),
                onChanged: (value) {
                  setState(() => _importanceLevel = value);
                },
              ),
              const Spacer(),
              // زر الحفظ المرتبط بالمتحكم
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  if (_titleController.text.isNotEmpty) {
                    // إرسال البيانات للمتحكم مباشرة بدلاً من الـ pop
                    controller.addTask(_titleController.text, _importanceLevel);

                    // العودة للصفحة السابقة
                    Get.back();

                    // إظهار رسالة نجاح
                    Get.snackbar(
                      isArabic ? "تمت الإضافة" : "Added",
                      isArabic ? "تم إضافة المهمة بنجاح" : "Task added successfully",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  } else {
                    Get.snackbar(
                      isArabic ? "خطأ" : "Error",
                      isArabic ? "يرجى كتابة عنوان المهمة" : "Please enter task title",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text(isArabic ? "حفظ المهمة" : "Save Task",
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}