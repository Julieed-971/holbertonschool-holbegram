import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/widgets/text_field.dart';
import 'signup_screen.dart';
import 'package:holbegram/screens/upload_image_screen.dart';
import 'package:provider/provider.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/home.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  final TextEditingController _signupEmailController = TextEditingController();
  final TextEditingController _signupUsernameController =
      TextEditingController();
  final TextEditingController _signupPasswordController =
      TextEditingController();
  final TextEditingController _signupPasswordConfirmController =
      TextEditingController();
  final AuthMethode _authMethode = AuthMethode();

  @override
  void dispose() {
    // 2. CLEAN UP MEMORY (Crucial to prevent leaks)
    _signupEmailController.dispose();
    _signupUsernameController.dispose();
    _signupPasswordController.dispose();
    _signupPasswordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 28),
            Text(
              "Holbegram",
              style: TextStyle(fontFamily: "Billabong", fontSize: 50),
            ),
            Image(
              image: AssetImage('assets/images/logo.webp'),
              width: 80,
              height: 60,
            ),
            SizedBox(height: 28),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFieldInput(
                    controller: widget.emailController,
                    hintText: "Email",
                    ispassword: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  TextFieldInput(
                    controller: widget.passwordController,
                    hintText: "Password",
                    ispassword: !_passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      alignment: Alignment.bottomLeft,
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color.fromARGB(218, 226, 37, 24),
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 28),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(218, 226, 37, 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () async {
                        String res = await _authMethode.login(
                          email: widget.emailController.text,
                          password: widget.passwordController.text,
                        );
                        if (res == 'success') {
                          try {
                            final userProvider = Provider.of<UserProvider>(
                              context,
                              listen: false,
                            );
                            await userProvider.refreshUser();
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login successful")),
                              );
                              await Future.delayed(const Duration(seconds: 2));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            }
                          } catch (error) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Login successful, but failed to load profile: $error",
                                  ),
                                ),
                              );
                            }
                          }
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(res)));
                          }
                        }
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),
            Row(
              spacing: 2,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Forgot your login details?"),
                Text(
                  "Get help logging in",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Flexible(flex: 0, child: Container()),
            SizedBox(height: 24),
            Divider(thickness: 2, indent: 20, endIndent: 20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account"),
                  TextButton(
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(
                            emailController: _signupEmailController,
                            usernameController: _signupUsernameController,
                            passwordController: _signupPasswordController,
                            passwordConfirmController:
                                _signupPasswordConfirmController,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(218, 226, 37, 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(child: Divider(thickness: 2, indent: 20)),
                Text(" OR "),
                Flexible(child: Divider(thickness: 2, endIndent: 20)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
                  width: 40,
                  height: 40,
                ),
                Text("Sign in with Google"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
