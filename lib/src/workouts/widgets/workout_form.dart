import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scheduler_flutter/bloc_provider.dart';

import 'package:scheduler_flutter/src/shared/widgets/alert_delete.dart';
import 'package:scheduler_flutter/src/shared/widgets/card-section.dart';
import 'package:scheduler_flutter/src/workouts/models/workout.dart';

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
        child:
            Column(children: <Widget>[_workoutName(), _formButtons(context)]));
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

  CardSection _formButtons(BuildContext context) {
    final workoutsBloc = BlocProvider.of(context).workoutsBloc;

    return CardSection(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              IconButton(
                onPressed: () {
                  _saveWorkout(context);
                },
                icon: Icon(Icons.check),
                color: Color(0xFF39a1e7),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
            ]),
            IconButton(
                onPressed: () async {
                  var delete = await _showAlertDelete(context);
                  if (delete) {
                    if (widget.workout.isUpdate()) {
                      workoutsBloc.delete.add(widget.workout);
                    }
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.delete),
                color: Colors.red),
          ]),
      showBottomBorder: false,
    );
  }

  _saveWorkout(BuildContext context) {
    final workoutsBloc = BlocProvider.of(context).workoutsBloc;

    if (this._formKey.currentState.validate()) {
      // update info from form into current meal
      _formKey.currentState.save();
      workoutsBloc.save.add(widget.workout);
    }

    Navigator.pop(context);
  }

  Future<bool> _showAlertDelete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return showAlertDelete(context);
        });
  }
}
