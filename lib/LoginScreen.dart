import 'package:flutter/material.dart';

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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You are not logged in.',
            ),
          ],
        ),
      ),
    );
  }
}