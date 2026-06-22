import 'package:flutter/material.dart';
import 'package:holbegram/screens/login_screen.dart';

class LoginWrapper extends StatefulWidget {
  const LoginWrapper({super.key});

  @override
  State<LoginWrapper> createState() => _LoginWrapperState();
}

class _LoginWrapperState extends State<LoginWrapper> {
  // Create controllers specifically for Login
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up memory
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      emailController: emailController,
      passwordController: passwordController,
    );
  }
}
