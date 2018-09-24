import 'package:flutter/material.dart';

import 'package:scheduler_flutter/bloc_provider.dart';
import 'package:scheduler_flutter/src/schedules/schedules_bloc.dart';
import 'package:scheduler_flutter/src/schedules/widgets/schedule_controls.dart';
import 'package:scheduler_flutter/src/schedules/widgets/schedule_days.dart';

class DaySchedule extends StatelessWidget {
  Widget build(BuildContext context) {
    final schedulesBloc = BlocProvider.of(context).schedulesBloc;

    return StreamBuilder<DateTime>(
        stream: schedulesBloc.date$,
        builder: (context, snapshot) => snapshot.hasData
            ? _buildScheduler(snapshot.data, schedulesBloc)
            : Text('No date...',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)));
  }

  Widget _buildScheduler(DateTime date, SchedulesBloc bloc) {
    return StreamBuilder(
        stream: bloc.dateSelected$,
        builder: (context, snapshot) => snapshot.hasData
            ? Column(
                children: <Widget>[
                  ScheduleControls(date, () => bloc.increaseDate(7),
                      () => bloc.decreaseDate(7)),
                  ScheduleDays(snapshot.data.difference(date).inDays,
                      (weekday) => bloc.weekday.add(weekday)),
                  Text(snapshot.data.toString())
                ],
              )
            : CircularProgressIndicator());
  }
}
