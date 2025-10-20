import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final Function(String email, String password) onRegister;

  const RegisterPage({Key? key, required this.onRegister}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrasi Akun"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            onRegister("user@example.com", "password123");
            Navigator.pop(context);
          },
          child: const Text("Register"),
        ),
      ),
    );
  }
}