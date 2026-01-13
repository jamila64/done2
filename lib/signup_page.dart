import 'package:flutter/material.dart';
import 'home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // تعريف القائمة (List) لتخزين المستخدمين المسجلين
  final List<Map<String, String>> _usersList = [];

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // الحفاظ على التصميم الحالي كما هو تماماً
      appBar: AppBar(title: const Text("إنشاء حساب جديد"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.account_circle, size: 100, color: Colors.indigo),
            const SizedBox(height: 30),
            // حقل اسم المستخدم
            TextField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: "اسم الطالب",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                filled: true,
                fillColor: Colors.indigo.withOpacity(0.05),
              ),
            ),
            const SizedBox(height: 15),
            // حقل كلمة المرور
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "كلمة المرور",
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                filled: true,
                fillColor: Colors.indigo.withOpacity(0.05),
              ),
            ),
            const SizedBox(height: 30),
            // زر إنشاء الحساب باستخدام القائمة
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
              onPressed: () {
                if (_userController.text.isNotEmpty && _passController.text.isNotEmpty) {
                  setState(() {
                    // إضافة البيانات المدخلة إلى الـ List
                    _usersList.add({
                      "userName": _userController.text,
                      "password": _passController.text,
                    });
                  });

                  // طباعة القائمة في التيرمينال للتأكد من الإضافة
                  print("القائمة الحالية للمستخدمين: $_usersList");

                  // الانتقال لصفحة الهوم مع تمرير الاسم الأخير المسجل
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(userName: _userController.text),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("الرجاء إدخال كافة البيانات")),
                  );
                }
              },
              child: const Text("إنشاء حساب ودخول", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}