
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoodHistoryScreen extends StatelessWidget {
  const MoodHistoryScreen({super.key});

  Object _moodColor(String mood) {
    switch (mood) {
      case 'Happy':
        return '😊';
      case 'Sad':
        return '😢';
      case 'Angry':
        return '😡';
      case 'Neutral':
        return '😐';
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.sizeOf(context).height;
    double screenwidth = MediaQuery.sizeOf(context).width;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.lightBlue, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            ),
          ),
          child: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            backgroundColor: Colors.transparent,
            title: const Text('Mood History',style: TextStyle(color: Colors.black87),),
            actions: [
              IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: screenheight,
        width: screenwidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.lightBlue,Colors.purpleAccent])
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('moods')
              .where('timestamp', isGreaterThanOrEqualTo: oneWeekAgo)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, index) {
                final data = docs[index];
                final mood = data['mood'];
                final note = data['note'] ?? '';
                final timestamp = (data['timestamp'] as Timestamp).toDate();

                return Padding(
                  padding:  EdgeInsets.only(right:screenwidth*0.05,left: screenwidth*0.05),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 1.5,
                      ),
                    ),
                    elevation:4,
                    child: Center(
                      child: ListTile(
                        title: Text('${_moodColor(mood)} \t $mood - ${timestamp.toLocal()}',style: TextStyle(color:Colors.black87,fontSize: 15),),
                        subtitle: Text(note),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
