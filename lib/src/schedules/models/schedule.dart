import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler_flutter/src/meals/models/meal.dart';
import 'package:scheduler_flutter/src/workouts/models/workout.dart';

class Schedule {
  // unique autogenerated by database or provider
  String _id;

  final DateTime date;
  final Meal meal;
  final Workout workout;

  Schedule(this.meal, this.workout) : date = DateTime.now();

  // // these methods might fit better in the providers
  Schedule.fromSnapshot(DocumentSnapshot snapshot)
      : _id = snapshot.documentID,
        date = snapshot.data['date'],
        meal = null,
        workout = null;

  // let timestamp: Timestamp = documentSnapshot.get("created_at") as! Timestamp
  // let date: Date = timestamp.dateValue()

  Map<String, dynamic> toSnapshot() => {'date': date};

  String get id => _id;
}
