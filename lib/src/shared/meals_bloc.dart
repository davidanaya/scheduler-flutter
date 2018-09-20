import 'dart:async';

import 'package:rxdart/subjects.dart';

import 'package:scheduler_flutter/src/models/meal.dart';
import 'package:scheduler_flutter/src/models/meals.dart';

class MealsBloc {
  final Meals _meals = Meals();

  final _meals$ = BehaviorSubject<List<Meal>>(seedValue: []);

  final StreamController<Meal> _mealRemovalController =
      StreamController<Meal>();

  final StreamController<Meal> _mealAdditionController =
      StreamController<Meal>();

  MealsBloc() {
    _mealRemovalController.stream.listen((meal) {
      _meals.remove(meal);
      _meals$.add(_meals.meals);
    });

    _mealAdditionController.stream.listen((meal) {
      _meals.add(meal);
      _meals$.add(_meals.meals);
    });
  }

  Sink<Meal> get mealRemoval => _mealRemovalController.sink;

  Sink<Meal> get mealAddition => _mealAdditionController.sink;

  Stream<List<Meal>> get meals$ => _meals$.stream;

  void dispose() {
    _meals$.close();
    _mealRemovalController.close();
    _mealAdditionController.close();
  }
}
