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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You are not logged in.',
            ),
            const SizedBox(height: 5),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home Page")));
            }, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}