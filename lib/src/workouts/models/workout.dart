import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  // unique autogenerated by database or provider
  String _id;

  String name;
  String type = 'Strength'; // Endurance | Strength
  dynamic strength;
  dynamic endurance;

  Workout({this.name});

  // these methods might fit better in the providers
  Workout.fromSnapshot(DocumentSnapshot snapshot)
      : _id = snapshot.documentID,
        name = snapshot.data['name'],
        type = snapshot.data['type'],
        strength = snapshot.data['strength'],
        endurance = snapshot.data['endurance'];

  Map<String, dynamic> toSnapshot() => {
        'name': name,
        'type': type,
        'strength': strength,
        'endurance': endurance
      };

  Map<String, dynamic> toSqliteMap() {
    var map = {
      'name': name,
      'type': type,
      'strength': json.encode(strength),
      'endurance': json.encode(endurance)
    };
    if (_id != null) map['id'] = _id;
    return map;
  }

  Workout.fromSqliteMap(Map map)
      : _id = map['id'].toString(),
        name = map['name'],
        type = map['type'],
        strength = json.decode(map['strength']),
        endurance = json.decode(map['endurance']);

  String get id => _id;

  bool isUpdate() {
    return _id != null;
  }

  @override
  String toString() {
    return '$name ($type) -> ${type == "strength" ? strength : endurance}';
  }
}