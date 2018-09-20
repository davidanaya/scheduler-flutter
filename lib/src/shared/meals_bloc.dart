import 'dart:async';

import 'package:rxdart/subjects.dart';

import 'package:scheduler_flutter/src/models/meal.dart';
import 'package:scheduler_flutter/src/models/meals.dart';

class MealUpdater {
  Meal updated;
  Meal update;

  MealUpdater(this.updated, this.update);
}

class MealsBloc {
  final Meals _meals = Meals();

  final _meals$ = BehaviorSubject<List<Meal>>(seedValue: []);

  final StreamController<Meal> _removalController = StreamController<Meal>();

  final StreamController<Meal> _additionController = StreamController<Meal>();

  final StreamController<MealUpdater> _updateController =
      StreamController<MealUpdater>();

  MealsBloc() {
    _removalController.stream.listen((meal) {
      _meals.remove(meal);
      _meals$.add(_meals.meals);
    });

    _additionController.stream.listen((meal) {
      _meals.add(meal);
      _meals$.add(_meals.meals);
    });

    _updateController.stream.listen((updater) {
      _meals.update(updater.updated, updater.update);
      _meals$.add(_meals.meals);
    });
  }

  Sink<Meal> get removal => _removalController.sink;

  Sink<Meal> get addition => _additionController.sink;

  Sink<MealUpdater> get update => _updateController.sink;

  Stream<List<Meal>> get meals$ => _meals$.stream;

  void dispose() {
    _meals$.close();
    _removalController.close();
    _additionController.close();
    _updateController.close();
  }
}
