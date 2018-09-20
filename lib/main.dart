import 'package:flutter/material.dart';

import 'package:scheduler_flutter/src/pages/meals_list.dart';
import 'package:scheduler_flutter/src/pages/schedule.dart';
import 'package:scheduler_flutter/src/pages/workouts.dart';

import 'package:scheduler_flutter/src/shared/app_bar.dart';
import 'package:scheduler_flutter/src/shared/meals_provider.dart';
import 'package:scheduler_flutter/src/shared/theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MealsProvider(
      child: MaterialApp(
        title: 'Ultimate Flutter',
        theme: appTheme,
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [Schedule(), MealsList(), Workouts()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6fafd),
      appBar: appBar,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Schedule'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('Meals'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.rowing), title: Text('Workouts'))
        ],
      ),
    );
  }
}
