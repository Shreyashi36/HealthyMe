// import 'package:flutter/material.dart';
// import 'package:healthy_me/widgets/button.dart';
// import 'package:healthy_me/widgets/camera_preview.dart';

// class DayDetailsPage extends StatelessWidget {
//   final int dayNumber;

//   DayDetailsPage({required this.dayNumber});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Day $dayNumber Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Day $dayNumber Exercises'),
//             CustomButton(
//               text: "Record Video",
//               onPressed: () {
//                 // Navigate to video recording page
//                 // You'll need to create a new page for this
//                 // log('Navigate to video recording for Day $dayNumber');
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => VideoRecorder(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:healthy_me/widgets/button.dart';
import 'package:healthy_me/widgets/camera_preview.dart';

class DayDetailsPage extends StatelessWidget {
  final int dayNumber;

  DayDetailsPage({required this.dayNumber});

  String _getImagePath(int dayNumber) {
    // Logic to determine the image path based on the day number.
    // You can use a switch statement, a map, or any other logic.
    switch (dayNumber) {
      case 1:
        return 'assets/images/day_details/day_1.png'; // Replace with your actual image path
      case 2:
        return 'assets/images/day_details/day_1.png'; // Replace with your actual image path
      case 3:
        return 'assets/images/day_details/day_1.png'; // Replace with your actual image path
      // Add more cases for other days
      default:
        return 'assets/images/day_details/day_1.png'; // Default image if no match
    }
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = _getImagePath(dayNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text('Day $dayNumber Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Day $dayNumber Exercises'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(imagePath,
                  width: 200, height: 200), // Display the image
            ),
            CustomButton(
              text: "Record Video",
              onPressed: () {
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
