import 'package:flutter/material.dart';
import 'package:patterns_for_flutter_web/firebase_auth/auth_service.dart';

class AuthSignUpView extends StatefulWidget {
  const AuthSignUpView({Key? key}) : super(key: key);

  @override
  State<AuthSignUpView> createState() => _AuthSignUpViewState();
}

class _AuthSignUpViewState extends State<AuthSignUpView> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phoneNumbercontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.55,
          height: screenHeight * 0.55,
          color: Colors.blue,
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1),
              inputField(context, 'name', _namecontroller, 'Mona Roza', false),
              SizedBox(height: screenHeight * 0.01),
              inputField(context, 'phone number', _phoneNumbercontroller,
                  '+90 1547 785 4125', false),
              SizedBox(height: screenHeight * 0.01),
              inputField(context, 'e-mail', _emailcontroller,
                  'monaroza@monaroza.com', false),
              SizedBox(height: screenHeight * 0.01),
              inputField(context, 'password', _pwcontroller, '******', true),
              SizedBox(height: screenHeight * 0.01),
              MaterialButton(
                onPressed: () async => AuthService().signup(
                    context,
                    _namecontroller.text,
                    _emailcontroller.text,
                    _phoneNumbercontroller.text,
                    _pwcontroller.text),
                color: Colors.blue.shade900,
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              MaterialButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/firebaseauthsignin'),
                child: const Text(
                  "Already have an account? Sign in now!",
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
