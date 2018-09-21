import 'dart:async';

import 'package:rxdart/subjects.dart';

import 'package:scheduler_flutter/src/models/meal.dart';
import 'package:scheduler_flutter/src/services/meals_service.dart';

class MealsBloc {
  final _meals$ = BehaviorSubject<List<Meal>>(seedValue: []);

  final StreamController<Meal> _deleteController = StreamController<Meal>();

  final StreamController<Meal> _saveController = StreamController<Meal>();

  final MealsService _service;

  MealsBloc(this._service) {
    _deleteController.stream.listen((meal) {
      _service.delete(meal).catchError(_handleError);
    });

    _saveController.stream.listen((meal) {
      _service.save(meal).catchError(_handleError);
    });

    _service.meals$.listen((meals) {
      _meals$.add(meals);
    });
  }

  Sink<Meal> get delete => _deleteController.sink;

  Sink<Meal> get save => _saveController.sink;

  Stream<List<Meal>> get meals$ => _meals$.stream;

  void dispose() {
    _meals$.close();
    _deleteController.close();
    _saveController.close();
  }

  _handleError(e) {
    print(e);
  }
}
