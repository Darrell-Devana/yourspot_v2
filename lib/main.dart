import 'package:flutter/material.dart';
import 'package:yourspot_v2/HomePage.dart';
import 'LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLoginScreen(title: "Login Screen",),
      debugShowCheckedModeBanner: false,
      routes: {
        "/home" : (context) => const MyHomePage(title: "Home Page")
      },
    );
  }
}