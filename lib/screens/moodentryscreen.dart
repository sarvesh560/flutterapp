
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoodLoggingScreen extends StatefulWidget {
  const MoodLoggingScreen({super.key});

  @override
  State<MoodLoggingScreen> createState() => _MoodLoggingScreenState();
}
class _MoodLoggingScreenState extends State<MoodLoggingScreen> {
  String? _selectedMood;
    final Map<String, String> moodEmojis = {
         'Happy': '😊',
         'Sad': '😢',
         'Angry': '😡',
          'Neutral': '😐',
  };

  final _noteController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitMood() async {
    if (_selectedMood == null) return;

    setState(() {
      _isLoading = true;
    });

    final userId = FirebaseAuth.instance.currentUser!.uid;
    final today = DateTime.now();
    final todayId = '${today.year}-${today.month}-${today.day}';

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('moods')
        .doc(todayId);

    final docSnap = await docRef.get();

    if (docSnap.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have already logged today\'s mood.')),
      );
    } else {
      await docRef.set({
        'mood': _selectedMood!,
        'note': _noteController.text.trim(),
        'timestamp': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mood saved!')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.sizeOf(context).height;
    double screenwidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
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
            title: const Text('Mood Tracker',style: TextStyle(color: Colors.black87),),
            actions: [
              IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenheight,
          width: screenwidth,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.lightBlue,Colors.purpleAccent])
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top:screenheight*0.01,
                    left: screenwidth*0.01,
                    right: screenwidth*0.01,
                  ),
                  child: Container(
                      height: 300,
                      width: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue[54],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.tealAccent, width: 2),
                      ),
                      child: Text(
                        _selectedMood != null ? moodEmojis[_selectedMood]! : '😀',
                        style: TextStyle(fontSize: 150),
                      ),
                    ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding:  EdgeInsets.only(top: screenheight*0.001,
                    left: screenwidth*0.06,
                    right: screenwidth*0.06,
                  ),
                  child: Container(
                    height: 55,
                    width:350 ,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.purpleAccent,Colors.lightBlueAccent]),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                        iconEnabledColor: Colors.black,
                        iconSize: 50,
                        value: _selectedMood,
                        hint: const Text('Select Mood',style: TextStyle(fontSize: 20),),
                        items:moodEmojis.keys
                            .map((mood) => DropdownMenuItem(value: mood, child: Text(mood)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedMood = value;
                          });
                        },
                        ),
                      ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding:  EdgeInsets.only(top: screenheight*0.001,
                    left: screenwidth*0.06,
                    right: screenwidth*0.06,
                  ),
                  child: Card(
                    elevation: 10,
                    child: TextField(
                      controller: _noteController,
                      decoration:  InputDecoration(hintText: 'Notes (optional)',
                      border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                _isLoading
                    ? const CircularProgressIndicator()
                    : Padding(
                  padding:  EdgeInsets.only(top: screenheight*0.001,
                    left: screenwidth*0.06,
                    right: screenwidth*0.06,
                  ),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.purpleAccent,Colors.lightBlueAccent]),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: ElevatedButton(
                                          style:ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black87,
                          shadowColor:Colors.transparent,
                          minimumSize: Size(350, 50),),
                                          onPressed: _submitMood,
                                          child: const Text('Save Mood',style: TextStyle(fontSize: 20),),
                                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
