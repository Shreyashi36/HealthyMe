import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthy_me/auth/auth_service.dart';
import 'package:healthy_me/auth/forgot_pass.dart';
import 'package:healthy_me/screens/home.dart';
import 'package:healthy_me/screens/welcome_page.dart';
import 'package:healthy_me/widgets/button.dart';
import 'package:healthy_me/widgets/custom_image.dart';
import 'package:healthy_me/widgets/textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F2FF), // Light blue background
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4A4A4A), // Dark gray text color
                      ),
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomImage(height: constraints.maxWidth * 0.6),
                    SizedBox(height: 30),
                    CustomTextField(
                      controller: _email,
                      labelText: 'Email',
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _password,
                      labelText: 'Password',
                      isPassword: true,
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: Text('Forgot Password?',
                            style: TextStyle(color: Color(0xFF5A5A97))),
                      ),
                    ),
                    CustomButton(text: 'Login', onPressed: _login),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => goToSignUp(context), // ✅ Fixed
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Color(0xFF5A5A97)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  goToSignUp(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );
  }

  goToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  _login() async {
    try {
      final user = await _auth.loginUserWithEmailAndPassword(
          _email.text, _password.text);
      if (user != null) {
        log("User Logged In");
        Future.delayed(Duration(milliseconds: 100), () {
          if (mounted) goToHome(context);
        });
      } else {
        _showErrorDialog("Invalid email or password.");
      }
    } catch (e) {
      log("Login failed: $e");
      _showErrorDialog("Login failed. Please try again.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }
}
