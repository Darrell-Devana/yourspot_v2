import 'package:flutter/material.dart';
import 'package:yourspot_v2/home_page.dart';
import 'package:yourspot_v2/signup_screen.dart';
import 'signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const MySigninScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/signin": (context) => const MySigninScreen(),
        "/signup": (context) => const MySignupScreen(),
        "/home": (context) => const MyHomePage(title: "Home Page"),
      },
    );
  }
}
