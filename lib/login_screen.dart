import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyLoginScreen extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: SizedBox(
                  child: Image.asset("assets/images/MUI_Logo.png"),
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email or Username',
                  ),
                ),
              ), // TextField
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
                    const TextStyle(fontSize: 16),
                  ),
                ),
                onPressed: () {
                  Fluttertoast.showToast(msg: "Continue");
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
            ],
          ),
        ),
      ),
    );
  }
}
