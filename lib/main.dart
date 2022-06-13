import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:patterns_for_flutter_web/firebase_auth/auth_sign_in_view.dart';
import 'package:patterns_for_flutter_web/firebase_auth/auth_sign_out_view.dart';
import 'package:patterns_for_flutter_web/firebase_storage/storage_view.dart';
import 'package:patterns_for_flutter_web/homepage.dart';

import 'firebase_auth/auth_sign_up_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patterns For Flutter Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => const HomePage(),
        '/pickimageandposttofirebase': (context) => const StorageView(),
        '/firebaseauthsignin': (context) => const AuthSignInView(),
        '/firebaseauthsignout': (context) => const AuthSignOutView(),
        '/firebaseauthsignup': (context) => const AuthSignUpView(),
      },
    );
  }
}
