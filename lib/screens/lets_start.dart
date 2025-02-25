import 'package:flutter/material.dart';
import 'package:healthy_me/screens/home.dart';
import 'package:healthy_me/widgets/button.dart';

class PlanSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'All types',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildPlanType('Full body', Color(0xFFE0F7FA)),
                  _buildPlanType('Upper', Color(0xFFE0F7FA)),
                  _buildPlanType('Lower', Color(0xFFE0F7FA)),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'All Levels',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildPlanCard(
                'easy plan',
                'Lorem ipsum dolor sit amen connectetur. Id amatorci viverra id',
                'assets/images/starter_page/easy_plan.png',
                Color(0xFFE0F7FA),
              ),
              SizedBox(height: 10),
              _buildPlanCard(
                'Normal plan',
                'Lorem ipsum dolor sit amet consectetur AITET OPCI viverra id',
                'assets/images/starter_page/normal_plan.png',
                Color(0xFFE0F7FA),
              ),
              SizedBox(height: 10),
              _buildPlanCard(
                'Hard plan',
                'Lorem ipsum dolor sit amet consectetur id amet orol id',
                'assets/images/starter_page/hard_plan.png',
                Color(0xFFE0F7FA),
              ),
              SizedBox(height: 10),
              _buildPlanCard(
                'Super flexible',
                'Lorem ipsum dolor sit amet. consectetur id amet orci',
                'assets/images/starter_page/super_flexible.png',
                Color(0xFFE0F7FA),
              ),
              Spacer(),
              Center(
                child: CustomButton(
                  text: 'Start your plan',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanType(String text, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text),
    );
  }

  Widget _buildPlanCard(String title, String description, String imagePath,
      Color backgroundColor) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 50),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(description, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
