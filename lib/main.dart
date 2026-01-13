import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() => runApp(const StudentApp());

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const Splashscreen(), // يبدأ من شاشة الترحيب
    );
  }
}