import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: Text('Patterns For Flutter Web App'))),
      body: Padding(
        padding: EdgeInsets.all(screenwidth * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buttons('/pickimageandposttofirebase', 'Firebase Storage'),
            buttons('/firebaseauthsignup', 'Firebase Auth Sign Up'),
            buttons('/firebaseauthsignin', 'Firebase Auth Sign In'),
            buttons('/firebaseauthsignout', 'Firebase Auth Sign Out'),
          ],
        ),
      ),
    );
  }

  Widget buttons(String link, String title) {
    return MaterialButton(
      height: 60,
      color: Colors.blue,
      onPressed: () => Navigator.pushNamed(context, link),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
