import 'dart:async';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:scheduler_flutter/bloc_provider.dart';
import 'package:scheduler_flutter/src/shared/widgets/action_button.dart';
import 'package:scheduler_flutter/src/shared/widgets/alert_delete.dart';
import 'package:scheduler_flutter/src/shared/widgets/card-section.dart';
import 'package:scheduler_flutter/src/shared/widgets/card_title.dart';
import 'package:scheduler_flutter/src/shared/widgets/icon_label.dart';
import 'package:scheduler_flutter/src/workouts/models/workout.dart';
import 'package:scheduler_flutter/src/workouts/pages/workout_detail.dart';

class WorkoutsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFf6fafd),
      margin: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[_workoutsTitle(context), _workoutsList(context)],
      ),
    );
  }

  CardTitle _workoutsTitle(BuildContext context) {
    return CardTitle(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[_workoutsLabel(), _btnAddWorkouts(context)],
    ));
  }

  ActionButton _btnAddWorkouts(BuildContext context) {
    return ActionButton(
        text: '+ NEW',
        fn: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WorkoutDetail()));
        });
  }

  IconLabel _workoutsLabel() {
    return IconLabel(icon: FontAwesomeIcons.dumbbell, label: 'Your workouts');
  }

  CardSection _workoutsList(BuildContext context) {
    final workoutsBloc = BlocProvider.of(context).workoutsBloc;

    return CardSection(
      child: StreamBuilder<List<Workout>>(
          stream: workoutsBloc.workouts$,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return Column(
                  children: snapshot.data
                      .map((workout) => WorkoutTile(
                          workout: workout,
                          onRemove: () {
                            workoutsBloc.delete.add(workout);
                          }))
                      .toList());
            }
            return Text('No workouts, add a new workout to start',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500));
          }),
      showBottomBorder: false,
    );
  }
}

class WorkoutTile extends StatelessWidget {
  final Workout workout;
  final Function onRemove;

  WorkoutTile({this.workout, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(new PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      WorkoutDetail(workout: workout)));
            },
            child: ListTile(
              title: Text(workout.name),
              subtitle: Text(
                workout.isStrength
                    ? workout.strengthToString()
                    : workout.enduranceToString(),
                style: TextStyle(
                    color: Color(0xFF8ea6bd),
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic),
              ),
            )),
      ),
      IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () async {
          var delete = await _showAlertDelete(context);
          if (delete) onRemove();
        },
      )
    ]);
  }

  Future<bool> _showAlertDelete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return showAlertDelete(context);
        });
  }
}
