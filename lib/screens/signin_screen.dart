import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MySigninScreen extends StatefulWidget {
  static const String routeName = "/signin";
  const MySigninScreen({super.key});

  @override
  State<MySigninScreen> createState() => _MySigninScreenState();
}

class _MySigninScreenState extends State<MySigninScreen> {
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
        Navigator.pushReplacementNamed(context, "/signup");
      };
    _emailUsernameController.addListener(_textFieldListener);
    _passwordController.addListener(_textFieldListener);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    () => Navigator.pushReplacementNamed(context, "/home");

    return await FirebaseAuth.instance.signInWithCredential(credential);
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

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailUsernameController.text.trim(),
        password: _passwordController.text,
      );

      // User login successful
      if (kDebugMode) {
        print("User logged in: ${userCredential.user?.email}");
      }
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      // Handle login errors
      if (kDebugMode) {
        print("Error during registration: $e");
      }
      if (e.toString().contains('The email address is badly formatted.')) {
        Fluttertoast.showToast(msg: "Invalid username or password");
      }
      if (e.toString().contains('email address is already in use')) {
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
                _logo(),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _renderWidget(),
                ),
                _signInButton(),
                const SizedBox(height: 20),
                _richText(),
                const SizedBox(height: 13),
                const Divider(
                  indent: 40,
                  endIndent: 40,
                ),
                const SizedBox(height: 20),
                _googleLogo(),
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

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: SizedBox(
        child: SvgPicture.asset("assets/images/MUI_Logo.svg"),
      ),
    );
  }

  Widget _signInButton() {
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
              _signInWithEmailAndPassword();
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
        _textFieldID == 1 ? "CONTINUE" : "SIGN IN",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _richText() {
    return RichText(
      text: TextSpan(
        text: "Don't have an Account? ",
        style: const TextStyle(color: Colors.black, fontSize: 13),
        children: [
          TextSpan(
            text: "Sign up",
            recognizer: _signUpRecognizer,
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _googleLogo() {
    return InkWell(
      onTap: () {
        signInWithGoogle();
      },
      child: Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            SvgPicture.asset(
              "assets/images/google_logo.svg",
              height: 30,
            ),
            const Spacer(),
            const Text(
              "Sign in with Google",
              style: TextStyle(fontSize: 15),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
