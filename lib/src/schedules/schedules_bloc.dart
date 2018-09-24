import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'package:scheduler_flutter/app_bloc.dart';
import 'package:scheduler_flutter/src/schedules/models/schedule.dart';
import 'package:scheduler_flutter/src/schedules/services/schedules_service.dart';

class SchedulesBloc extends Bloc {
  DateTime _date = DateTime.now();
  final _date$ = BehaviorSubject<DateTime>(seedValue: DateTime.now());
  final _weekday$ = BehaviorSubject<int>(seedValue: 0);

  final _schedules$ = BehaviorSubject<List<Schedule>>(seedValue: []);

  final StreamController<Schedule> _deleteController =
      StreamController<Schedule>();

  final StreamController<Schedule> _saveController =
      StreamController<Schedule>();

  final SchedulesService _service;

  SchedulesBloc(this._service) {
    _deleteController.stream.listen((schedule) {
      _service.delete(schedule).catchError(_handleError);
    });

    _saveController.stream.listen((schedule) {
      _service.save(schedule).catchError(_handleError);
    });

    _service.schedules$.listen((schedules) {
      _schedules$.add(schedules);
    });
  }

  Sink<Schedule> get delete => _deleteController.sink;

  Sink<Schedule> get save => _saveController.sink;

  Sink<int> get weekday => _weekday$.sink;

  Stream<DateTime> get date$ => _date$.stream;

  Stream<DateTime> get dateSelected$ => Observable.combineLatest2(
      date$,
      _weekday$.stream,
      (DateTime date, int weekday) => date.add(Duration(days: weekday)));

  void increaseDate(int days) {
    _date = _date.add(Duration(days: days));
    _date$.add(_date);
  }

  void decreaseDate(int days) {
    _date = _date.subtract(Duration(days: days));
    _date$.add(_date);
  }

  void dispose() {
    _date$.close();
    _weekday$.close();
    _deleteController.close();
    _saveController.close();
  }

  _handleError(e) {
    print(e);
  }
}
