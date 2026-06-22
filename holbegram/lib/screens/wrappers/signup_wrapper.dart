import 'package:flutter/material.dart';
import 'package:holbegram/screens/signup_screen.dart';

class SignupWrapper extends StatefulWidget {
  const SignupWrapper({super.key});

  @override
  State<SignupWrapper> createState() => _SignupWrapperState();
}

class _SignupWrapperState extends State<SignupWrapper> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignupScreen(
      emailController: emailController,
      usernameController: usernameController,
      passwordController: passwordController,
      passwordConfirmController: passwordConfirmController,
    );
  }
}
