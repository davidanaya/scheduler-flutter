import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class ScheduleControls extends StatelessWidget {
  final DateTime date;
  final Function increaseFn;
  final Function decreaseFn;

  ScheduleControls(this.date, this.increaseFn, this.decreaseFn);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FlatButton(
          onPressed: decreaseFn,
          child: Icon(Icons.arrow_back),
        ),
        Expanded(
            child: Text(
          DateFormat.yMMMd().format(date),
          textAlign: TextAlign.center,
        )),
        FlatButton(
          onPressed: increaseFn,
          child: Icon(Icons.arrow_forward),
        )
      ],
    );
  }
}
