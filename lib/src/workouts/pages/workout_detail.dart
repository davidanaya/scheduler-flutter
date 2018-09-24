import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:scheduler_flutter/src/shared/app_bar.dart';
import 'package:scheduler_flutter/src/shared/widgets/card_title.dart';
import 'package:scheduler_flutter/src/shared/widgets/icon_label.dart';
import 'package:scheduler_flutter/src/workouts/models/workout.dart';
import 'package:scheduler_flutter/src/workouts/widgets/workout_form.dart';

class WorkoutDetail extends StatefulWidget {
  final Workout workout;

  WorkoutDetail({workout}) : this.workout = workout ?? Workout();

  @override
  _WorkoutDetailState createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  // if we try to use widget.workout instead, on every render a new Workout instance is created
  Workout _workout;

  @override
  void initState() {
    _workout = widget.workout ?? Workout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Card(
            color: Color(0xFFf6fafd),
            margin: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _workoutTitle(),
                WorkoutForm(_workout),
              ],
            ),
          ),
        ));
  }

  CardTitle _workoutTitle() {
    return CardTitle(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[_workoutLabel()],
    ));
  }

  IconLabel _workoutLabel() {
    return IconLabel(
        icon: FontAwesomeIcons.dumbbell,
        label: _workout != null && _workout.isUpdate()
            ? 'Save'
            : 'Create workout');
  }
}
