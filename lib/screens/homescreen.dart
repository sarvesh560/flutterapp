
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'moodentryscreen.dart';
import 'moodhistory.dart';
import 'moodinsights.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: Container(
        height: screenheight,
        width: screenwidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.lightBlue,Colors.purpleAccent])
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
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
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.black87,
                          minimumSize: Size(340, 50),
                          elevation: 0),
                    child: const Text('Log Today\'s Mood',style: TextStyle(fontSize: 20),),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MoodLoggingScreen()));
                    },
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
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
                        shadowColor:Colors.transparent ,
                        foregroundColor: Colors.black87,
                        minimumSize: Size(340, 50),
                        elevation: 0),
                    child: const Text('Mood History',style: TextStyle(fontSize: 20),),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MoodHistoryScreen()));
                    },
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
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
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.black87,
                        minimumSize: Size(340, 50),
                        elevation: 0),
                    child: const Text('Mood Insights',style: TextStyle(fontSize: 20),),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MoodInsightsScreen()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
