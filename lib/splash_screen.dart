import 'dart:async';
import 'package:flutter/material.dart';
import 'signup_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignupPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text("متتبع المهام الذكي", style: TextStyle(color: Colors.white, fontSize: 24)),
          ],
        ),
      ),
    );
  }
}