import 'package:flutter/material.dart';
import 'package:healthy_me/auth/auth_service.dart';
import 'package:healthy_me/screens/home.dart';
import 'package:healthy_me/screens/welcome_page.dart';
import 'package:healthy_me/widgets/custom_image.dart';

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

  bool _obsecureText = true;

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
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4A4A4A), // Dark gray text color
                    ),
                  ),
                  //Login
                  Text('Login',
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
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
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
                  ElevatedButton(
                    //////////////////////////
                    onPressed: _login,
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
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  SizedBox(height: 20), // Spacing between buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                          onPressed: goToSignUp(context),
                          child: Text(
                            'Sign Up',
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

  goToSignUp(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  goToHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  _login() async {
    final user =
        await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      print("User Logged In");
      goToHome(context);
    }
  }
}
