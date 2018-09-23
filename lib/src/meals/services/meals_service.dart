import 'dart:async';

import 'package:scheduler_flutter/src/meals/models/meal.dart';

abstract class MealsService {
  Future<void> save(Meal meal);

  Stream<List<Meal>> get meals$;

  Future<void> delete(Meal meal);
}
