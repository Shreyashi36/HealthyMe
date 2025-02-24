import 'package:flutter/material.dart';
import 'package:healthy_me/auth/auth_service.dart';
import 'package:healthy_me/widgets/button.dart';
import 'package:healthy_me/widgets/textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = AuthService();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Color(0xFFE6F2FF),
        body: Center(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Image.asset(
                      'assets/images/forgot_password.png',
                      height: 200,
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Don't worry, we'll send you a reset instructions.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomTextField(controller: _email, labelText: "Email"),
                    SizedBox(height: 30),
                    CustomButton(
                        text: "Reset Password",
                        onPressed: () async {
                          await _auth.sendPasswordResetLink(_email.text);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Password reset link has been sent to your email."),
                          ));
                        }),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Remember the password?"),
                        TextButton(
                          onPressed: () {
                            // Login action
                            Navigator.pop(context); // Go back to login screen
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Color(0xFF5A5A97)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
