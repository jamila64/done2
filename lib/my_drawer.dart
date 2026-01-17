import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // جلب المتحكم للوصول للبيانات (الاسم، الصورة، اللغة، والفلترة)
    final TaskController controller = Get.find();

    return Drawer(
      child: Obx(() => Directionality(
        textDirection: controller.isArabic.value ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          children: [
            // --- قسم رأس القائمة (Header) مع الصورة والاسم ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              color: Colors.indigo,
              child: Column(
                children: [
                  // عرض الصورة الشخصية المحفوظة
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    backgroundImage: controller.userImage.value.isNotEmpty
                        ? FileImage(File(controller.userImage.value))
                        : null,
                    child: controller.userImage.value.isEmpty
                        ? const Icon(Icons.person, size: 45, color: Colors.indigo)
                        : null,
                  ),
                  const SizedBox(height: 15),
                  // عرض اسم المستخدم
                  Text(
                    controller.userName.value.isEmpty
                        ? (controller.isArabic.value ? "اسم الطالب" : "Student Name")
                        : controller.userName.value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- خيارات الفلترة والقائمة ---

            // 1. كل المهام
            _buildDrawerItem(
              icon: Icons.list_alt,
              title: controller.isArabic.value ? "كل المهام" : "All Tasks",
              color: Colors.indigo,
              onTap: () {
                controller.filterType.value = "all";
                Get.back();
              },
            ),

            // 2. المهام المكتملة
            _buildDrawerItem(
              icon: Icons.check_circle_outline,
              title: controller.isArabic.value ? "المهام المكتملة" : "Completed Tasks",
              color: Colors.green,
              onTap: () {
                controller.filterType.value = "completed";
                Get.back();
              },
            ),

            // 3. المهام غير المكتملة (الطلب الجديد)
            _buildDrawerItem(
              icon: Icons.pending_actions,
              title: controller.isArabic.value ? "مهام قيد الإنجاز" : "Pending Tasks",
              color: Colors.orange,
              onTap: () {
                controller.filterType.value = "pending";
                Get.back();
              },
            ),

            const Divider(),

            // 4. الإعدادات
            _buildDrawerItem(
              icon: Icons.settings_outlined,
              title: controller.isArabic.value ? "الإعدادات" : "Settings",
              color: Colors.grey,
              onTap: () {
                Get.back();
                Get.toNamed('/settings');
              },
            ),

            const Spacer(), // دفع زر الخروج للأسفل
            const Divider(),

            // 5. تسجيل الخروج
            _buildDrawerItem(
              icon: Icons.logout,
              title: controller.isArabic.value ? "تسجيل الخروج" : "Logout",
              color: Colors.red,
              onTap: () => controller.logout(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      )),
    );
  }

  // دالة بناء العناصر بالتصميم الجانبي الملون
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border(
            // الخط الجانبي الملون (يتغير حسب اللغة يمين/يسار)
            right: Get.find<TaskController>().isArabic.value
                ? BorderSide(color: color, width: 6)
                : BorderSide.none,
            left: !Get.find<TaskController>().isArabic.value
                ? BorderSide(color: color, width: 6)
                : BorderSide.none,
          ),
        ),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}