import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scheduler_flutter/src/shared/widgets/card-section.dart';
import 'package:scheduler_flutter/src/workouts/models/workout.dart';

class WorkoutTypeSelector extends StatefulWidget {
  final int _initialSelection;
  final Function _selectFn;

  WorkoutTypeSelector(this._initialSelection, this._selectFn);

  @override
  _WorkoutTypeSelectorState createState() => _WorkoutTypeSelectorState();
}

class _WorkoutTypeSelectorState extends State<WorkoutTypeSelector> {
  int _currentSelection = 0;

  @override
  void initState() {
    _currentSelection = widget._initialSelection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CardSection(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
                color: _currentSelection == 0
                    ? Color(0xFFe8ecf0)
                    : Color(0xFFf5f9fd),
                icon: Icon(FontAwesomeIcons.dumbbell, size: 20.0),
                label: Text(
                  'STRENGTH',
                  style: TextStyle(fontSize: 12.0),
                ),
                onPressed: () {
                  setState(() {
                    _currentSelection = 0;
                  });
                  widget._selectFn(WorkoutType.strength);
                }),
          ),
          Expanded(
            child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
                color: _currentSelection == 1
                    ? Color(0xFFe8ecf0)
                    : Color(0xFFf5f9fd),
                icon: Icon(Icons.rowing, size: 25.0),
                label: Text(
                  'ENDURANCE',
                  style: TextStyle(fontSize: 12.0),
                ),
                onPressed: () {
                  setState(() {
                    _currentSelection = 1;
                  });
                  widget._selectFn(WorkoutType.endurance);
                }),
          ),
        ],
      ),
      showBottomBorder: true,
    );
  }

  String _getWorkoutLabel(WorkoutType type) {
    return type.toString().substring(type.toString().indexOf('.') + 1);
  }
}
