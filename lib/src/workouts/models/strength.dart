import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Strength {
  int reps = 0;
  int sets = 0;
  int weight = 0;

  void strengthFromSnapshot(DocumentSnapshot snapshot) {
    reps = snapshot.data['reps'];
    sets = snapshot.data['sets'];
    weight = snapshot.data['weight'];
  }

  Map<String, dynamic> strengthToSnapshot() =>
      {'reps': reps, 'sets': sets, 'weight': weight};

  String strengthToString() {
    return 'Reps: $reps Sets: $sets Weight: $weight';
  }
}
