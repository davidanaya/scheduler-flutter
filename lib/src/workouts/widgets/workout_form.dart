import 'package:flutter/material.dart';

import 'package:scheduler_flutter/bloc_provider.dart';
import 'package:scheduler_flutter/src/shared/widgets/card-section.dart';
import 'package:scheduler_flutter/src/shared/widgets/form_buttons.dart';
import 'package:scheduler_flutter/src/workouts/models/workout.dart';
import 'package:scheduler_flutter/src/workouts/widgets/workout_type_selector.dart';

class WorkoutForm extends StatefulWidget {
  final Workout workout;

  WorkoutForm(this.workout);

  @override
  _WorkoutFormState createState() => _WorkoutFormState();
}

class _WorkoutFormState extends State<WorkoutForm> {
  final TextEditingController _nameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.workout.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          _workoutName(),
          WorkoutTypeSelector(widget.workout.isStrength ? 0 : 1, _onSelectType),
          widget.workout.isStrength ? Text('STRENGTH') : Text('ENDURANCE'),
          _formButtons(context)
        ]));
  }

  _onSelectType(WorkoutType type) {
    setState(() {
      widget.workout.setType(type);
    });
  }

  CardSection _workoutName() {
    return CardSection(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
          child: TextFormField(
            validator: (value) =>
                value.isEmpty ? 'Workout name can\'t be empty!' : null,
            controller: _nameController,
            onSaved: (String value) {
              widget.workout.name = value;
            },
            decoration: _textFieldDecoration(
                label: 'Workout name', hint: 'e.g. Chest press'),
          )),
      showBottomBorder: true,
    );
  }

  InputDecoration _textFieldDecoration({String label, String hint}) {
    return InputDecoration(
        contentPadding: EdgeInsets.all(12.0),
        labelText: label,
        labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.0),
        border: OutlineInputBorder());
  }

  FormButtons _formButtons(BuildContext context) {
    return FormButtons(_saveWorkout, _deleteWorkout);
  }

  _deleteWorkout(BuildContext context) {
    final workoutsBloc = BlocProvider.of(context).workoutsBloc;
    if (widget.workout.isUpdate()) {
      workoutsBloc.delete.add(widget.workout);
    }
  }

  _saveWorkout(BuildContext context) {
    final workoutsBloc = BlocProvider.of(context).workoutsBloc;

    print('WORKOUT ${widget.workout}');
    if (this._formKey.currentState.validate()) {
      // update info from form into current meal
      _formKey.currentState.save();
      workoutsBloc.save.add(widget.workout);
    }

    Navigator.pop(context);
  }
}
