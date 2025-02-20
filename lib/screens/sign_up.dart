import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthy_me/auth/auth_service.dart';
import 'package:healthy_me/screens/home.dart';
import 'package:healthy_me/screens/login.dart';
import 'package:healthy_me/widgets/custom_image.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _fullName = TextEditingController();
  bool _obsecureText = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _fullName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE6F2FF), // Light blue background
        body: SafeArea(child: Center(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Welcome Back
                  Text(
                    'Hello Beautiful',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4A4A4A), // Dark gray text color
                    ),
                  ),
                  //Login
                  Text('Sign Up',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A4A4A), // Dark gray text color
                      )),
                  SizedBox(height: 20), // Spacing between title and image
                  //image
                  CustomImage(
                    height: constraints.maxWidth *
                        0.6, // Adjust aspect ratio as needed
                  ),
                  //spacing
                  SizedBox(height: 30),

                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    controller: _fullName,
                  ),

                  SizedBox(height: 20),

                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    controller: _email,
                  ),

                  SizedBox(height: 20),
                  TextField(
                    obscureText: _obsecureText,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          icon: Icon(_obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obsecureText = !_obsecureText;
                            });
                          }),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    controller: _password,
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        //Forgot password action
                      },
                      child: Text('Forgot Password?',
                          style: TextStyle(color: Color(0xFF5A5A97))),
                    ),
                  ),

                  //sign up button
                  ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                      backgroundColor:
                          Color(0xFF5A5A97), // Dark purple button color
                      foregroundColor: Colors.white, // White text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  SizedBox(height: 20), // Spacing between buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Color(0xFF5A5A97)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        }))));
  }

  goToHome(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  _signup() async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          _email.text, _password.text);

      if (user != null) {
        log("User created successfully: ${user.email}");
        goToHome(context);
      } else {
        log("User creation failed");
      }
    } catch (e) {
      log("Error signing up: $e"); // Debugging info
    }
  }
}
