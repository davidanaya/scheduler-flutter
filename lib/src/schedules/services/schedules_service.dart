import 'dart:async';

import 'package:scheduler_flutter/src/schedules/models/schedule.dart';

abstract class SchedulesService {
  Future<void> save(Schedule schedule);

  Stream<List<Schedule>> get schedules$;

  Future<void> delete(Schedule schedule);
}
