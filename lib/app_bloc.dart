import 'package:scheduler_flutter/src/meals/meals_bloc.dart';
import 'package:scheduler_flutter/src/workouts/workouts_bloc.dart';

abstract class Bloc {
  Sink<dynamic> get delete;
  Sink<dynamic> get save;
}

class AppBloc {
  final MealsBloc _meals;
  final WorkoutsBloc _workouts;

  AppBloc(mealsService, workoutsService)
      : _meals = MealsBloc(mealsService),
        _workouts = WorkoutsBloc(workoutsService);

  MealsBloc get mealsBloc => _meals;

  WorkoutsBloc get workoutsBloc => _workouts;
}
