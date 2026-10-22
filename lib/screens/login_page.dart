// NAMA : DYAH W SULISTYANINGTYAS
// NRP  : 162024002
// ISB 311 - SIS PRAKTIKUM

import 'package:flutter/material.dart';
import 'register_page.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // _formKey digunakan untuk mengontrol validasi form.
  // Controller digunakan untuk menyimpan input pengguna.
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D05FA), Color(0xFF2980B9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/login.png',
                    height: 350,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "Masukkan email dan password Anda untuk melanjutkan",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Input email
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'contoh: NamaKamu@email.com',
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }

                                final emailPattern = RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+$',
                                );

                                if (!emailPattern.hasMatch(value)) {
                                  return 'Format email tidak valid';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Input password
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }

                                if (value.length < 6) {
                                  return 'Password minimal 6 karakter';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 30),

                            // Tombol Masuk
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF2980B9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  // Validasi seluruh input form
                                  if (_formKey.currentState!.validate()) {
                                    // Pindah ke homepage setelah validasi berhasil
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MainScreen(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Navigasi ke halaman registrasi
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Belum punya akun? Daftar di sini',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
