import 'dart:collection';

import 'package:scheduler_flutter/src/models/meal.dart';

class Meals {
  final List<Meal> _meals = [];

  Meals();

  int get mealsCount => _meals.length;

  UnmodifiableListView<Meal> get meals => UnmodifiableListView(_meals);

  void add(Meal meal) {
    var index = _mealIndex(meal);
    if (index != -1) {
      _update(meal, index);
    } else {
      _meals.add(meal);
    }
  }

  void remove(Meal meal) {
    if (_mealIndex(meal) != -1) _meals.remove(meal);
  }

  void update(Meal updated, Meal update) {
    var index = _mealIndex(updated);
    if (index != -1) {
      _update(update, index);
    }
  }

  int _mealIndex(Meal meal) {
    var found =
        _meals.firstWhere((e) => e.name == meal.name, orElse: () => null);
    return found != null ? _meals.indexOf(found) : -1;
  }

  void _update(Meal meal, int index) {
    _meals[index] = meal;
  }

  @override
  String toString() => '$meals';
}
