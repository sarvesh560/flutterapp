import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference moods = FirebaseFirestore.instance.collection('moods');
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> logMood(String mood, String note, DateTime date) async {
    String dateKey = "${date.year}-${date.month}-${date.day}";

    await moods.doc('$uid-$dateKey').set({
      'uid': uid,
      'mood': mood,
      'note': note,
      'date': date,
    });
  }

  Stream<QuerySnapshot> getMoodHistory() {
    DateTime last7Days = DateTime.now().subtract(const Duration(days: 7));
    return moods
        .where('uid', isEqualTo: uid)
        .where('date', isGreaterThanOrEqualTo: last7Days)
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future<void> updateNote(String docId, String note) async {
    await moods.doc(docId).update({'note': note});
  }
}
