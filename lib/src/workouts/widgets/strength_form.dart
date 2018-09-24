import 'package:flutter/material.dart';

import 'package:scheduler_flutter/src/shared/widgets/card-section.dart';
import 'package:scheduler_flutter/src/workouts/models/workout.dart';

class StrengthForm extends StatefulWidget {
  final Workout workout;

  StrengthForm(this.workout);

  @override
  _StrengthFormState createState() => _StrengthFormState();
}

class _StrengthFormState extends State<StrengthForm> {
  // we could mantain the state of the edit fields adding state here
  // now, if user clicks between strength and endurance, non committed changes are lost
  @override
  Widget build(BuildContext context) {
    return CardSection(
      child: Column(children: <Widget>[
        _strengthItem('Reps', widget.workout.reps.toString(),
            (value) => widget.workout.reps = int.parse(value)),
        _strengthItem('Sets', widget.workout.sets.toString(),
            (value) => widget.workout.sets = int.parse(value)),
        _strengthItem('Weight', widget.workout.weight.toString(),
            (value) => widget.workout.weight = int.parse(value),
            units: 'kg')
      ]),
      showBottomBorder: true,
    );
  }

  Widget _strengthItem(String text, String initialValue, Function saveFn,
      {String units}) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Column(children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Row(children: _labelWithUnits(text, units).toList()),
          ),
          TextFormField(
            initialValue: initialValue,
            keyboardType: TextInputType.number,
            onSaved: saveFn,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12.0),
                border: OutlineInputBorder()),
          )
        ]));
  }

  Iterable<Widget> _labelWithUnits(String text, String units) sync* {
    yield Text(text,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600));

    if (units != null) {
      yield Padding(
          padding: EdgeInsets.only(left: 4.0), child: Text('($units)'));
    }
  }
}
