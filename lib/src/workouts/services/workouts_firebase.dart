import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:scheduler_flutter/src/workouts/models/workout.dart';
import 'package:scheduler_flutter/src/workouts/services/workouts_service.dart';

class WorkoutsFirebase extends WorkoutsService {
  final Stream<QuerySnapshot> _snapshots$;
  final CollectionReference _collection;

  WorkoutsFirebase()
      : _snapshots$ = Firestore.instance.collection('workouts').snapshots(),
        _collection = Firestore.instance.collection('workouts');

  @override
  Future<void> save(Workout workout) {
    return _collection.document(workout.id).setData(workout.toSnapshot());
  }

  @override
  Stream<List<Workout>> get workouts$ =>
      _snapshots$.map((snapshot) => snapshot.documents
          .map((document) => Workout.fromSnapshot(document))
          .toList());

  @override
  Future<void> delete(Workout workout) {
    return _collection.document(workout.id).delete();
  }
}
