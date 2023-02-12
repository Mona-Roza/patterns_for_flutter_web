import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patterns_for_flutter_web/firebase_auth/auth_service.dart';

class AuthSignOutView extends StatefulWidget {
  const AuthSignOutView({Key? key}) : super(key: key);

  @override
  State<AuthSignOutView> createState() => _AuthSignOutViewState();
}

class _AuthSignOutViewState extends State<AuthSignOutView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return _auth.currentUser != null ? user(context) : notUser(context);
  }

  Widget user(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Out'),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.blue,
          onPressed: () => AuthService().signout(context),
          child: const Text(
            'Sign Out',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget notUser(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Out'),
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          width: screenWidth * 0.55,
          height: screenHeight * 0.55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("You didn't sign in, please",
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/firebaseauthsignin'),
                child: const Text("sign in",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              const Text("or", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/firebaseauthsignup'),
                child: const Text("sign up",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
