// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class MoodInsightsScreen extends StatefulWidget {
//   const MoodInsightsScreen({super.key});
//
//   @override
//   State<MoodInsightsScreen> createState() => _MoodInsightsScreenState();
// }
//
// class _MoodInsightsScreenState extends State<MoodInsightsScreen> {
//   Map<String, int> moodCount = {};
//   int totalEntries = 0;
//   String mostFrequentMood = '';
//   double happyPercentage = 0;
//   int longestStreak = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _calculateInsights();
//   }
//
//   Future<void> _calculateInsights() async {
//     final userId = FirebaseAuth.instance.currentUser!.uid;
//     final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
//
//     final snap = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .collection('moods')
//         .where('timestamp', isGreaterThanOrEqualTo: oneWeekAgo)
//         .orderBy('timestamp')
//         .get();
//
//     Map<String, int> countMap = {};
//     List<String> moodList = [];
//
//     for (var doc in snap.docs) {
//       final mood = doc['mood'];
//       countMap[mood] = (countMap[mood] ?? 0) + 1;
//       moodList.add(mood);
//     }
//
//     int happyDays = countMap['Happy'] ?? 0;
//     String frequentMood = '';
//     int maxCount = 0;
//
//     countMap.forEach((mood, count) {
//       if (count > maxCount) {
//         maxCount = count;
//         frequentMood = mood;
//       }
//     });
//
//     int streak = 1;
//     int maxStreak = 1;
//
//     for (int i = 1; i < moodList.length; i++) {
//       if (moodList[i] == moodList[i - 1]) {
//         streak += 1;
//         if (streak > maxStreak) maxStreak = streak;
//       } else {
//         streak = 1;
//       }
//     }
//
//     setState(() {
//       moodCount = countMap;
//       totalEntries = snap.docs.length;
//       mostFrequentMood = frequentMood;
//       happyPercentage =
//       totalEntries == 0 ? 0 : (happyDays / totalEntries) * 100;
//       longestStreak = maxStreak;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenheight = MediaQuery
//         .sizeOf(context)
//         .height;
//     double screenwidth = MediaQuery
//         .sizeOf(context)
//         .width;
//     return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(kToolbarHeight),
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [Colors.lightBlue, Colors.purpleAccent],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight
//               ),
//             ),
//             child: AppBar(
//               elevation: 0,
//               iconTheme: IconThemeData(color: Colors.black87),
//               backgroundColor: Colors.transparent,
//               title: const Text(
//                 'Mood Insights', style: TextStyle(color: Colors.black87),),
//               actions: [
//                 IconButton(
//                   onPressed: () => FirebaseAuth.instance.signOut(),
//                   icon: const Icon(Icons.exit_to_app),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body:
//         Container(
//             height: screenheight,
//             width: screenwidth,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     colors: [Colors.lightBlue, Colors.purpleAccent])
//             ),
//
//             child: Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Most Frequent Mood: $mostFrequentMood'),
//                     Text(
//                         'Happy Days %: ${happyPercentage.toStringAsFixed(1)}%'),
//                     Text('Longest Mood Streak: $longestStreak'),
//                   ],
//                 ),
//               ),
//             )
//         )
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoodInsightsScreen extends StatefulWidget {
  const MoodInsightsScreen({super.key});

  @override
  State<MoodInsightsScreen> createState() => _MoodInsightsScreenState();
}

class _MoodInsightsScreenState extends State<MoodInsightsScreen> {
  Map<String, int> moodCount = {};
  int totalEntries = 0;
  String mostFrequentMood = '';
  double happyPercentage = 0;
  int longestStreak = 0;

  @override
  void initState() {
    super.initState();
    _calculateInsights();
  }

  Future<void> _calculateInsights() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));

    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('moods')
        .where('timestamp', isGreaterThanOrEqualTo: oneWeekAgo)
        .orderBy('timestamp')
        .get();

    Map<String, int> countMap = {};
    List<String> moodList = [];

    for (var doc in snap.docs) {
      final mood = doc['mood'];
      countMap[mood] = (countMap[mood] ?? 0) + 1;
      moodList.add(mood);
    }

    int happyDays = countMap['Happy'] ?? 0;
    String frequentMood = '';
    int maxCount = 0;

    countMap.forEach((mood, count) {
      if (count > maxCount) {
        maxCount = count;
        frequentMood = mood;
      }
    });

    int streak = 1;
    int maxStreak = 1;

    for (int i = 1; i < moodList.length; i++) {
      if (moodList[i] == moodList[i - 1]) {
        streak += 1;
        if (streak > maxStreak) maxStreak = streak;
      } else {
        streak = 1;
      }
    }

    setState(() {
      moodCount = countMap;
      totalEntries = snap.docs.length;
      mostFrequentMood = frequentMood;
      happyPercentage =
      totalEntries == 0 ? 0 : (happyDays / totalEntries) * 100;
      longestStreak = maxStreak;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    final insights = [
      'Most Frequent Mood: $mostFrequentMood',
      'Happy Days %: ${happyPercentage.toStringAsFixed(1)}%',
      'Longest Mood Streak: $longestStreak',
      'Total Entries: $totalEntries',
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black87),
            backgroundColor: Colors.transparent,
            title: const Text(
              'Mood Insights',
              style: TextStyle(color: Colors.black87),
            ),
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
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.purpleAccent],
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.only(left: screenWidth*0.05,right: screenWidth*0.05),
          child: ListView.builder(
            itemCount: insights.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.lightBlueAccent, width: 1.5,),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    insights[index],
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
