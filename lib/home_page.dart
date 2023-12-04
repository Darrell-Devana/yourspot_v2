import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = "/home";
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, "/signin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body: const Center(
        child: Text("data"),
      ),
    );
  }
}
