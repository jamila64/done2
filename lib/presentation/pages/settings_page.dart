import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskController c = Get.find();
    return Obx(() => Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(c.isArabic.value ? "اللغة" : "Language"),
              trailing: DropdownButton<String>(
                value: c.isArabic.value ? "العربية" : "English",
                items: ["العربية", "English"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) {
                  c.isArabic.value = (val == "العربية");
                  Get.updateLocale(c.isArabic.value ? const Locale('ar') : const Locale('en'));
                },
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    ));
  }
}