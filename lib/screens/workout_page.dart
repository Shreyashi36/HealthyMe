import 'package:flutter/material.dart';
import 'package:healthy_me/screens/day_details.dart';
import 'package:healthy_me/widgets/button.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String _selectedPlan = 'Normal plan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Plan'),
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
              _selectedPlan,
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
              itemCount: 30,
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
    int exercises = dayNumber % 5 + 9;
    String duration = '${dayNumber % 3 + 4}:00 min';
    int calories = dayNumber * 3 + 90;

    return ListTile(
      leading: Icon(Icons.check_circle, color: Colors.blue),
      title: Text('Day $dayNumber'),
      subtitle: Text('$exercises Exercises   $duration   $calories Kcal'),
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
