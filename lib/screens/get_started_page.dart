import 'package:flutter/material.dart';
import 'package:healthy_me/screens/home.dart';
import 'package:healthy_me/screens/lets_start.dart';
import 'package:healthy_me/widgets/button.dart';

class PostSignupScreen extends StatelessWidget {
  const PostSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Added AppBar for back button
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
        leading: IconButton(
          // Back button
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Center(
                // Center the image
                child: Image.asset(
                  'assets/images/starter_page.png',
                  height: 400,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Feel stronger',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'learn from the world\'s best yoga coaches anytime at home or on the go.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    CustomButton(
                      text: 'Get Started',
                      onPressed: () {
                        goToPlanSelectionScreen(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  goToPlanSelectionScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PlanSelectionScreen()),
    );
  }
}
