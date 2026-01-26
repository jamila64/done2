import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:done/presentation/controllers/task_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController c = Get.find();
    return Drawer(
      child: Obx(() => Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.indigo),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: c.userImage.value.isNotEmpty ? FileImage(File(c.userImage.value)) : null,
              child: c.userImage.value.isEmpty ? const Icon(Icons.person, size: 40) : null,
            ),
            accountName: Text(c.userName.value, style: const TextStyle(fontWeight: FontWeight.bold)), accountEmail: null,
          ),
          _drawerItem(Icons.list, 'all'.tr, Colors.indigo, () { c.filterType.value = "all"; Get.back(); }),
          _drawerItem(Icons.pending, 'pending'.tr, Colors.orange, () { c.filterType.value = "pending"; Get.back(); }),
          _drawerItem(Icons.check_circle, 'completed'.tr, Colors.green, () { c.filterType.value = "completed"; Get.back(); }),
          const Divider(),
          _drawerItem(Icons.settings, 'settings'.tr, Colors.grey, () { Get.back(); Get.toNamed('/settings'); }),
          const Spacer(),
          _drawerItem(Icons.logout, 'logout'.tr, Colors.red, () => c.logout()),
          const SizedBox(height: 20),
        ],
      )),
    );
  }

  Widget _drawerItem(IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}