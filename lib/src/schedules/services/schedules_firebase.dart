import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:scheduler_flutter/src/schedules/models/schedule.dart';
import 'package:scheduler_flutter/src/schedules/services/schedules_service.dart';

class SchedulesFirebase extends SchedulesService {
  final Stream<QuerySnapshot> _snapshots$;
  final CollectionReference _collection;

  SchedulesFirebase()
      : _snapshots$ = Firestore.instance.collection('schedules').snapshots(),
        _collection = Firestore.instance.collection('schedules');

  @override
  Future<void> save(Schedule schedule) {
    return _collection.document(schedule.id).setData(schedule.toSnapshot());
  }

  @override
  Stream<List<Schedule>> get schedules$ =>
      _snapshots$.map((snapshot) => snapshot.documents
          .map((document) => Schedule.fromSnapshot(document))
          .toList());

  @override
  Future<void> delete(Schedule schedule) {
    return _collection.document(schedule.id).delete();
  }
}
