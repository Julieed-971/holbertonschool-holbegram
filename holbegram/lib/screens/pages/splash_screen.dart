import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holbegram/screens/home.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:holbegram/screens/wrappers/login_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      _checkAuth();
    });
  }

  Future<void> _checkAuth() async {
    final user = FirebaseAuth.instance.currentUser;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (user != null) {
      try {
        await userProvider.refreshUser();
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      } catch (e) {
        _goToLogin();
      }
    } else {
      // No user logged in
      _goToLogin();
    }
  }

  void _goToLogin() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginWrapper()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your Logo
            Image.asset('assets/images/logo.webp', width: 100, height: 80),
            const SizedBox(height: 20),
            // App Name
            const Text(
              "Holbegram",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 50,
                color: Color.fromARGB(218, 226, 37, 24),
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
