 //NAMA : DYAH W SULISTYANINGTYAS
 //NRP  : 162024002
 //ISB 311 - SIS PRAKTIKUM

import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToLogin();
  }

  Future<void> _goToLogin() async {
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF0E1),
              Color(0xFFD7B899),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/cafe.png',
              width: 160,
              height: 160,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.local_cafe,
                size: 120,
                color: Color(0xFF6F4E37),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'DnA Coffee',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E342E),
              ),
            ),
            const SizedBox(height: 8),
            const Text('A little coffee, a lot of happiness.'),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
