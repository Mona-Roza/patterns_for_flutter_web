import 'package:flutter/material.dart';
import 'package:patterns_for_flutter_web/firebase_auth/auth_service.dart';

class AuthSignInView extends StatefulWidget {
  const AuthSignInView({Key? key}) : super(key: key);

  @override
  State<AuthSignInView> createState() => _AuthSignInViewState();
}

class _AuthSignInViewState extends State<AuthSignInView> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.55,
          height: screenHeight * 0.55,
          color: Colors.blue,
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.18),
              inputField(
                  context, 'e-mail', _emailcontroller, 'Enter e-mail', false),
              SizedBox(height: screenHeight * 0.01),
              inputField(context, 'password', _pwcontroller, '******', true),
              SizedBox(height: screenHeight * 0.01),
              ElevatedButton(
                onPressed: () async => AuthService()
                    .signin(context, _emailcontroller.text, _pwcontroller.text),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              MaterialButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/firebaseauthsignup'),
                child: const Text(
                  "Don't have an account? Sign up now!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField(BuildContext context, String title,
      TextEditingController controller, String hint, bool obscureText) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: screenWidth * 0.08,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 5),
        Container(
          color: Colors.white,
          height: screenHeight * 0.06,
          width: screenWidth * 0.4,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.all(15.0),
            ),
          ),
        ),
      ],
    );
  }
}
