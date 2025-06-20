import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _submit(bool isLogin) async {
    final auth = FirebaseAuth.instance;
    try {
      if (isLogin) {
        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.sizeOf(context).height;
    double screenwidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        height: screenheight,
        width: screenwidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.lightBlue,Colors.purpleAccent])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding:  EdgeInsets.only(top: screenheight*0.01,
                bottom: screenheight*0.01,
                right: screenwidth*0.05,
                left: screenwidth*0.05
                ),
                child: Card(
                  elevation:20,
                  child: Container(
                    decoration: BoxDecoration(
                    color: Colors.transparent,
                    ),
                    height: 500,
                    width: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top:screenheight*0.001,bottom: screenheight*0.1),
                          child: Text("Login/Signup",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: screenheight*0.001,
                              left: screenwidth*0.06,
                              right: screenwidth*0.06,
                          ),
                          child: Card(
                            elevation: 10,
                            child: TextField(controller: _emailController,
                                decoration: const InputDecoration(hintText: 'Email',
                                border: OutlineInputBorder()
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
                            child: TextField(controller: _passwordController,
                                decoration: const InputDecoration(hintText: 'Password',
                                border: OutlineInputBorder()
                                ), obscureText: true),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding:  EdgeInsets.only(top: screenheight*0.001,
                            left: screenwidth*0.01,
                            right: screenwidth*0.01,
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
                                minimumSize: Size(300, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => _submit(true),
                              child: const Text('Login',style: TextStyle(fontSize: 20),),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding:  EdgeInsets.only(top: screenheight*0.001,
                            left: screenwidth*0.01,
                            right: screenwidth*0.01,
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
                                  minimumSize: Size(300, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                              ),
                              onPressed: () => _submit(false),
                              child: const Text('Sign Up',style: TextStyle(fontSize: 20),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

