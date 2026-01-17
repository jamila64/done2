import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  // استدعاء المتحكم
  final TaskController controller = Get.find();
  // متحكم النص لتعديل الاسم
  final TextEditingController nameEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // وضع الاسم الحالي في الحقل عند فتح الصفحة
    nameEditController.text = controller.userName.value;

    return Obx(() => Directionality(
      textDirection: controller.isArabic.value ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.isArabic.value ? "الإعدادات" : "Settings"),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // --- قسم تعديل الصورة الشخصية ---
              Center(
                child: Stack(
                  children: [
                    Obx(() => CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.indigo[100],
                      backgroundImage: controller.userImage.value.isNotEmpty
                          ? FileImage(File(controller.userImage.value))
                          : null,
                      child: controller.userImage.value.isEmpty
                          ? const Icon(Icons.person, size: 60, color: Colors.indigo)
                          : null,
                    )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.indigo,
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          onPressed: () => controller.pickImage(), // استدعاء دالة اختيار الصورة
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- حقل تعديل الاسم ---
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: TextField(
                    controller: nameEditController,
                    decoration: InputDecoration(
                      labelText: controller.isArabic.value ? "تعديل الاسم" : "Edit Name",
                      border: InputBorder.none,
                      icon: const Icon(Icons.edit, color: Colors.indigo),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- قسم تغيير اللغة (Dropdown) ---
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.language, color: Colors.indigo),
                  title: Text(controller.isArabic.value ? "لغة التطبيق" : "App Language"),
                  trailing: DropdownButton<String>(
                    value: controller.isArabic.value ? "العربية" : "English",
                    underline: const SizedBox(),
                    items: ["العربية", "English"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.isArabic.value = (newValue == "العربية");
                        Get.updateLocale(controller.isArabic.value
                            ? const Locale('ar')
                            : const Locale('en'));
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // --- زر حفظ التعديلات ---
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  if (nameEditController.text.isNotEmpty) {
                    controller.saveUser(nameEditController.text); // حفظ الاسم الجديد
                    Get.snackbar(
                      controller.isArabic.value ? "تم التحديث" : "Updated",
                      controller.isArabic.value ? "تم حفظ التعديلات بنجاح" : "Changes saved successfully",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  }
                },
                icon: const Icon(Icons.save, color: Colors.white),
                label: Text(
                  controller.isArabic.value ? "حفظ التغييرات" : "Save Changes",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}