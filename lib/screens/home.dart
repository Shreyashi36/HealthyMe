import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthy_me/widgets/button.dart';
import 'package:healthy_me/widgets/camera_preview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedPlan = 'Normal plan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        title: Text('Workout Plan'), // You can customize the title
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildPlanButton(
                    context, 'easy plan', 'assets/images/home_page/easy.png'),
                _buildPlanButton(context, 'Normal plan',
                    'assets/images/home_page/normal.png'),
                _buildPlanButton(
                    context, 'Hard plan', 'assets/images/home_page/hard.png'),
                _buildPlanButton(context, 'Super flexible',
                    'assets/images/home_page/super.png'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _selectedPlan, // Use the selected plan
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('If you never exercise'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(''),
                CustomButton(text: 'Start', onPressed: () {})
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 30, // Assuming 30 days
              itemBuilder: (context, index) {
                return _buildDayListItem(context, index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanButton(
      BuildContext context, String planName, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = planName;
        });
        print('Plan selected: $planName');
      },
      child: Column(
        children: <Widget>[
          Image.asset(imagePath, width: 50, height: 50),
          Text(planName),
        ],
      ),
    );
  }

  Widget _buildDayListItem(BuildContext context, int dayNumber) {
    // Replace with actual data fetching based on the selected plan
    int exercises = dayNumber % 5 + 9; // Example logic
    String duration = '${dayNumber % 3 + 4}:00 min'; // Example logic
    int calories = dayNumber * 3 + 90; // Example logic

    return ListTile(
      leading: Icon(Icons.check_circle, color: Colors.blue),
      title: Text('Day $dayNumber'),
      subtitle: Text('$exercises Exercises   $duration   $calories Kcal'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DayDetailsPage(dayNumber: dayNumber),
          ),
        );
      },
    );
  }
}

class DayDetailsPage extends StatelessWidget {
  final int dayNumber;

  DayDetailsPage({required this.dayNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day $dayNumber Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Day $dayNumber Exercises'),
            CustomButton(
              text: "Record Video",
              onPressed: () {
                // Navigate to video recording page
                // You'll need to create a new page for this
                // log('Navigate to video recording for Day $dayNumber');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoRecorder(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
