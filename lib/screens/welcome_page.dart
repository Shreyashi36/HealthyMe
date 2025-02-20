import 'package:flutter/material.dart';
import 'package:healthy_me/auth/auth_service.dart';
import 'package:healthy_me/screens/login.dart';
import 'package:healthy_me/screens/sign_up.dart';
import 'package:healthy_me/widgets/custom_image.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return Scaffold(
      backgroundColor: Color(0xFFE6F2FF), // Light blue background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Welcome to
            Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4A4A4A), // Dark gray text color
              ),
            ),

            //self care
            Text(
              'Self Care',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A4A4A), // Dark gray text color
              ),
            ),
            SizedBox(height: 40), // Spacing between title and image

            CustomImage(height: 250),

            SizedBox(height: 60),

            // Spacing between image and buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
                backgroundColor: Color(0xFF5A5A97), // Dark purple button color
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
                backgroundColor: Colors.white, // White button color
                foregroundColor: Color(0xFF5A5A97), // Dark purple text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
