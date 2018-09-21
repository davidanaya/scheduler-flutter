import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:scheduler_flutter/src/models/meal.dart';
import 'package:scheduler_flutter/src/services/meals_service.dart';

class MealsFirebase extends MealsService {
  final Stream<QuerySnapshot> _snapshots$;
  final CollectionReference _collection;

  MealsFirebase()
      : _snapshots$ = Firestore.instance.collection('meals').snapshots(),
        _collection = Firestore.instance.collection('meals');

  @override
  Future<void> save(Meal meal) {
    return _collection.document(meal.id).setData(meal.toSnapshot());
  }

  @override
  Stream<List<Meal>> get meals$ =>
      _snapshots$.map((snapshot) => snapshot.documents
          .map((document) => Meal.fromSnapshot(document))
          .toList());

  @override
  Future<void> delete(Meal meal) {
    return _collection.document(meal.id).delete();
  }
}
