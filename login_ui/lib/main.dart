import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/firebase_options.dart';
import 'package:login_ui/screens/login_screen.dart';

void main() async {
  // Initialize Firebase
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

