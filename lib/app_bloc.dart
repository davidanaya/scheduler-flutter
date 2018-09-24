import 'package:scheduler_flutter/src/meals/meals_bloc.dart';
import 'package:scheduler_flutter/src/meals/services/meals_service.dart';
import 'package:scheduler_flutter/src/schedules/schedules_bloc.dart';
import 'package:scheduler_flutter/src/schedules/services/schedules_service.dart';
import 'package:scheduler_flutter/src/workouts/services/workouts_service.dart';
import 'package:scheduler_flutter/src/workouts/workouts_bloc.dart';

abstract class Bloc {
  Sink<dynamic> get delete;
  Sink<dynamic> get save;
}

class AppBloc {
  final MealsBloc _meals;
  final WorkoutsBloc _workouts;
  final SchedulesBloc _schedules;

  AppBloc(MealsService mealsService, WorkoutsService workoutsService,
      SchedulesService schedulesService)
      : _meals = MealsBloc(mealsService),
        _workouts = WorkoutsBloc(workoutsService),
        _schedules = SchedulesBloc(schedulesService);

  MealsBloc get mealsBloc => _meals;

  WorkoutsBloc get workoutsBloc => _workouts;

  SchedulesBloc get schedulesBloc => _schedules;
}
