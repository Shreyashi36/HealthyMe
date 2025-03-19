// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:healthy_me/screens/day_details.dart';
// import 'package:healthy_me/widgets/button.dart';
// import 'package:healthy_me/widgets/camera_preview.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   String _selectedPlan = 'Normal plan';
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     // List of widgets to display for each tab
//     final List<Widget> _widgetOptions = <Widget>[
//       // Your existing Home page content goes here
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 _buildPlanButton(
//                     context, 'easy plan', 'assets/images/home_page/easy.png'),
//                 _buildPlanButton(context, 'Normal plan',
//                     'assets/images/home_page/normal.png'),
//                 _buildPlanButton(
//                     context, 'Hard plan', 'assets/images/home_page/hard.png'),
//                 _buildPlanButton(context, 'Super flexible',
//                     'assets/images/home_page/super.png'),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               _selectedPlan, // Use the selected plan
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text('If you never exercise'),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(''),
//                 CustomButton(text: 'Start', onPressed: () {})
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 30, // Assuming 30 days
//               itemBuilder: (context, index) {
//                 return _buildDayListItem(context, index + 1);
//               },
//             ),
//           ),
//         ],
//       ),
//       Text('Workout Page'), // Placeholder for the Workout page
//       Text('Profile Page'), // Placeholder for the Profile page
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Go back to the previous page
//           },
//         ),
//         title: Text('Workout Plan'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.more_vert),
//             onPressed: () {
//               // Handle more options
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         // Display the widget based on the selected tab
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fitness_center),
//             label: 'Workout',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }

//   void _onItemTapped(int index) {
//     // Function to handle tab changes
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Widget _buildPlanButton(
//       BuildContext context, String planName, String imagePath) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedPlan = planName;
//         });
//         print('Plan selected: $planName');
//       },
//       child: Column(
//         children: <Widget>[
//           Image.asset(imagePath, width: 50, height: 50),
//           Text(planName),
//         ],
//       ),
//     );
//   }

//   Widget _buildDayListItem(BuildContext context, int dayNumber) {
//     // Replace with actual data fetching based on the selected plan
//     int exercises = dayNumber % 5 + 9; // Example logic
//     String duration = '${dayNumber % 3 + 4}:00 min'; // Example logic
//     int calories = dayNumber * 3 + 90; // Example logic

//     return ListTile(
//       leading: Icon(Icons.check_circle, color: Colors.blue),
//       title: Text('Day $dayNumber'),
//       subtitle: Text('$exercises Exercises   $duration   $calories Kcal'),
//       trailing: Icon(Icons.chevron_right),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DayDetailsPage(dayNumber: dayNumber),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:healthy_me/screens/workout_page.dart'; // Import the WorkoutPage
import 'package:healthy_me/screens/profile_page.dart'; // Import the ProfilePage

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthy Me'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNavigationButton(
              context,
              'Workout',
              Icons.fitness_center,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutPage()),
                );
              },
            ),
            SizedBox(height: 20), // Add some spacing between buttons
            _buildNavigationButton(
              context,
              'Profile',
              Icons.person,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
