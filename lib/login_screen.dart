import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyLoginScreen extends StatefulWidget {
  static const String routeName = "/login";
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  late TapGestureRecognizer _signUpRecognizer;

  @override
  void initState() {
    super.initState();
    _signUpRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Fluttertoast.showToast(msg: "Sign up");
      };
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, "/home");

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: SizedBox(
                  child: SvgPicture.asset("assets/images/MUI_Logo.svg"),
                ),
              ), // Image
              RichText(
                text: TextSpan(
                  text: "Login or ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      recognizer: _signUpRecognizer,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const TextSpan(
                      text: " for free.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 60,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 20, top: 50, bottom: 50),
                    border: OutlineInputBorder(),
                    labelText: 'Email or Username',
                  ),
                ),
              ),
              FilledButton(
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
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
                child: const Text(
                  "CONTINUE",
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                indent: 40,
                endIndent: 40,
              ),
              const SizedBox(height: 20),
              InkWell(
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
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
