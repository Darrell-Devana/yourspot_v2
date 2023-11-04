import 'package:flutter/material.dart';
import 'HomePage.dart';

class MyLoginScreen extends StatefulWidget {

  const MyLoginScreen({super.key, required this.title});
  final String title;

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You are not logged in.',
            ),
            const SizedBox(height: 5),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
            }, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}