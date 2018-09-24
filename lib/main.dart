import 'package:flutter/material.dart';

import 'package:scheduler_flutter/app_bloc.dart';
import 'package:scheduler_flutter/bloc_provider.dart';
import 'package:scheduler_flutter/src/meals/pages/meals_list.dart';
import 'package:scheduler_flutter/src/meals/services/meals_firebase.dart';
import 'package:scheduler_flutter/src/meals/services/meals_sqlite.dart';
import 'package:scheduler_flutter/src/schedules/pages/day_schedule.dart';
import 'package:scheduler_flutter/src/schedules/services/schedules_firebase.dart';
import 'package:scheduler_flutter/src/shared/app_bar.dart';
import 'package:scheduler_flutter/src/shared/theme.dart';
import 'package:scheduler_flutter/src/workouts/pages/workouts_list.dart';
import 'package:scheduler_flutter/src/workouts/services/workouts_firebase.dart';

enum Api { firebase, sqlite }

void main() {
  final api = Api.firebase;

  var mealsService;
  var workoutsService;
  var schedulesService;

  switch (api) {
    case Api.sqlite:
      mealsService = MealsSqlite();
      // TODO implement sqlite provider for workouts and schedules
      workoutsService = WorkoutsFirebase();
      schedulesService = SchedulesFirebase();
      return;
    case Api.firebase:
    default:
      mealsService = MealsFirebase();
      workoutsService = WorkoutsFirebase();
      schedulesService = SchedulesFirebase();
  }

  final appBloc = AppBloc(mealsService, workoutsService, schedulesService);

  runApp(new MyApp(appBloc));
}

class MyApp extends StatelessWidget {
  final AppBloc bloc;

  MyApp(this.bloc);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
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

  final List<Widget> _children = [DaySchedule(), MealsList(), WorkoutsList()];

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
