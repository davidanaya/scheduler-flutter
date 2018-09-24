import 'package:flutter/material.dart';

import 'package:scheduler_flutter/src/shared/widgets/card-section.dart';
import 'package:scheduler_flutter/src/workouts/models/workout.dart';

class EnduranceForm extends StatefulWidget {
  final Workout workout;

  EnduranceForm(this.workout);

  @override
  _EnduranceFormState createState() => _EnduranceFormState();
}

class _EnduranceFormState extends State<EnduranceForm> {
  // we could mantain the state of the edit fields adding state here
  // now, if user clicks between Endurance and endurance, non committed changes are lost
  @override
  Widget build(BuildContext context) {
    return CardSection(
      child: Column(children: <Widget>[
        _enduranceItem('Distance', widget.workout.distance.toString(),
            (value) => widget.workout.distance = int.parse(value),
            units: 'km'),
        _enduranceItem('Duration', widget.workout.minutes.toString(),
            (value) => widget.workout.minutes = int.parse(value),
            units: 'minutes')
      ]),
      showBottomBorder: true,
    );
  }

  Widget _enduranceItem(String text, String initialValue, Function saveFn,
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
