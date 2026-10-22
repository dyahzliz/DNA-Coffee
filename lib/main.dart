//NAMA : DYAH W SULISTYANINGTYAS
//NRP  : 162024002
//ISB 311 - SIS PRAKTIKUM

import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DnA Coffee',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFFFFAF6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6F4E37),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
