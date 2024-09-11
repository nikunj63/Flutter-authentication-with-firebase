import 'package:flutter/material.dart';
import 'package:login_ui/Widgets/button.dart';
import 'package:login_ui/screens/login_screen.dart';
import 'package:login_ui/services/authentication.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(  
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Congratulations\nYou have successfully Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
            MyButton(
              onTab: () async {
                await AuthServices().signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
               text: 'Log Out',
               )
          ],
        ),
      ),
    );
  }
}