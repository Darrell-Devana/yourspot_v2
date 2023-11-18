import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MySignupScreen extends StatefulWidget {
  static const String routeName = "/signup";
  const MySignupScreen({super.key});

  @override
  State<MySignupScreen> createState() => _MySignupScreenState();
}

class _MySignupScreenState extends State<MySignupScreen> {
  late TapGestureRecognizer _signUpRecognizer;
  final TextEditingController _emailUsernameController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _textFieldID = 1;
  bool _isFilled = false;

  @override
  void initState() {
    super.initState();
    _signUpRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushReplacementNamed(context, "/signin");
      };
    _emailUsernameController.addListener(_textFieldListener);
    _passwordController.addListener(_textFieldListener);
  }

  Widget _renderWidget() {
    return _textFieldID == 1 ? _textField1() : _textField2();
  }

  void _updateWidget() {
    setState(() {
      _textFieldID = _textFieldID == 1 ? 2 : 1;
    });
  }

  void _textFieldListener() {
    if (_emailUsernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        _isFilled = true;
      });
    } else {
      setState(() {
        _isFilled = false;
      });
    }
  }

  Future<void> _registerWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailUsernameController.text.trim(),
        password: _passwordController.text,
      );

      // User registration successful
      if (kDebugMode) {
        print("User registered: ${userCredential.user?.email}");
      }
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      // Handle registration errors
      if (kDebugMode) {
        print("Error during registration: $e");
      }
      if (e.toString().contains('The email address is badly formatted.')) {
        Fluttertoast.showToast(msg: "Invalid username or password");
      }
      if (e.toString().contains('email address is already in use')) {
        // Provide feedback to the user that the email is already in use
        Fluttertoast.showToast(msg: "Email is already in use");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo(), // Image
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _renderWidget(),
                ),
                _signupButton(),
                const SizedBox(height: 20),
                _richText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField1() {
    return Container(
      width: 300,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: TextField(
        controller: _emailUsernameController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, top: 50, bottom: 50),
          border: OutlineInputBorder(),
          labelText: 'Email or Username',
        ),
      ),
    );
  }

  Widget _textField2() {
    return Column(
      children: [
        Container(
          width: 300,
          height: 60,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: TextField(
            controller: _emailUsernameController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 20, top: 50, bottom: 50),
              border: OutlineInputBorder(),
              labelText: 'Email or Username',
            ),
          ),
        ),
        Container(
          width: 300,
          height: 60,
          margin: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
          child: TextField(
            obscureText: true,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 20, top: 50, bottom: 50),
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
        ),
      ],
    );
  }

  Widget _richText() {
    return RichText(
      text: TextSpan(
        text: "Already have an Account? ",
        style: const TextStyle(color: Colors.black, fontSize: 13),
        children: [
          TextSpan(
            text: "Sign in",
            recognizer: _signUpRecognizer,
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: SizedBox(
        child: SvgPicture.asset("assets/images/MUI_Logo.svg"),
      ),
    );
  }

  Widget _signupButton() {
    return FilledButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        fixedSize: const MaterialStatePropertyAll(
          Size(300, 60),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 15),
        ),
      ),
      onPressed: _isFilled
          ? () {
              _registerWithEmailAndPassword();
            }
          : () {
              if (_emailUsernameController.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Please input your email or username");
              } else if (_textFieldID == 2) {
                Fluttertoast.showToast(msg: "Please input your password");
              } else {
                _updateWidget();
              }
            },
      child: Text(
        _textFieldID == 1 ? "CONTINUE" : "SIGN UP",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
