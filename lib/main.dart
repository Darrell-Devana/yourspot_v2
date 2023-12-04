import 'package:firebase_auth/firebase_auth.dart';
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
        appBarTheme: const AppBarTheme(
          color: Color(0x00023e8a),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00023e8a)),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MyHomePage(title: "YourSpot");
            } else {
              return const MySigninScreen();
            }
          }),
      debugShowCheckedModeBanner: true,
      routes: {
        "/signin": (context) => const MySigninScreen(),
        "/signup": (context) => const MySignupScreen(),
        "/home": (context) => const MyHomePage(title: "YourSpot"),
      },
    );
  }
}
