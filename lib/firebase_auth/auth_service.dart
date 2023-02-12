import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signin(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Signed in')));
      await Navigator.pushNamed(context, '/homepage');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User not found!')));
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Wrong password!')));
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong...')));
      }
    }
  }

  signup(BuildContext context, String name, String email, String phoneNumber,
      String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await verifyemail();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Signed up, please verify your e-mail')));
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'uid': _auth.currentUser!.uid
      });
      await Navigator.pushNamed(context, '/firebaseauthsignin');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('E-mail already in use')));
      } else if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Weak password!')));
      } else if (e.code == 'invalid-email') {
        return ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Invalid email!')));
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong...')));
      }
    }
  }

  signout(BuildContext context) async {
    if (_auth.currentUser != null) {
      try {
        await _auth.signOut();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Signed out')));
        await Navigator.pushNamed(context, '/homepage');
      } on FirebaseAuthException catch (e) {
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong...')));
      }
    }
  }

  verifyemail() async {
    if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
      await _auth.currentUser!.sendEmailVerification();
      return false;
    } else if (_auth.currentUser != null && _auth.currentUser!.emailVerified) {
      return true;
    }
  }
}
