import 'dart:async';

import 'package:rxdart/subjects.dart';

import 'package:scheduler_flutter/app_bloc.dart';
import 'package:scheduler_flutter/src/workouts/models/workout.dart';
import 'package:scheduler_flutter/src/workouts/services/workouts_service.dart';

class WorkoutsBloc extends Bloc {
  final _workouts$ = BehaviorSubject<List<Workout>>(seedValue: []);

  final StreamController<Workout> _deleteController =
      StreamController<Workout>();

  final StreamController<Workout> _saveController = StreamController<Workout>();

  final WorkoutsService _service;

  WorkoutsBloc(this._service) {
    _deleteController.stream.listen((workout) {
      _service.delete(workout).catchError(_handleError);
    });

    _saveController.stream.listen((workout) {
      _service.save(workout).catchError(_handleError);
    });

    _service.workouts$.listen((workouts) {
      _workouts$.add(workouts);
    });
  }

  Sink<Workout> get delete => _deleteController.sink;

  Sink<Workout> get save => _saveController.sink;

  Stream<List<Workout>> get workouts$ => _workouts$.stream;

  void dispose() {
    _workouts$.close();
    _deleteController.close();
    _saveController.close();
  }

  _handleError(e) {
    print(e);
  }
}
