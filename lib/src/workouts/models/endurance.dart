import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Endurance {
  int distance = 0;
  int minutes = 0;

  void enduranceFromSnapshot(DocumentSnapshot snapshot) {
    distance = snapshot.data['distance'];
    minutes = snapshot.data['minutes'];
  }

  Map<String, dynamic> enduranceToSnapshot() =>
      {'distance': distance, 'minutes': minutes};

  String enduranceToString() {
    return 'Distance: $distance Minutes: $minutes';
  }
}
