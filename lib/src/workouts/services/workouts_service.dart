import 'dart:async';

import 'package:scheduler_flutter/src/workouts/models/workout.dart';

abstract class WorkoutsService {
  Future<void> save(Workout workout);

  Stream<List<Workout>> get workouts$;

  Future<void> delete(Workout workout);
}
