import 'package:flutter/material.dart';
import 'package:login_ui/Widgets/button.dart';
import 'package:login_ui/Widgets/snack_bar.dart';
import 'package:login_ui/Widgets/textfield.dart';
import 'package:login_ui/screens/home_screen.dart';
import 'package:login_ui/screens/login_screen.dart';
import 'package:login_ui/services/authentication.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  
  void despose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();

  }
  void signUpUser() async {
  String res = await AuthServices().signUpUser(
    email:emailController.text,
    password: passwordController.text,
    name: nameController.text,
    );
    if(res == "success"){
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context)=> const HomeScreen(),
        )
      );
    }else{
      setState((){
        isLoading = false;
      });
      // show error massage
      showSnackbar(context, res);
    }



  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 2.8,
              child: Image.asset(
                "assets/images/signup.jpeg"
              ),
              ),
              TextfieldInput(
                textEditingController: nameController,
                 hintText: 'Enter your Name', 
                 icon: Icons.person, 
                 ),
                 TextfieldInput(
                textEditingController: emailController,
                 hintText: 'Enter your email', 
                 icon: Icons.email, 
                 ),
                 TextfieldInput(
                textEditingController: passwordController,
                 hintText: 'Enter your password', 
                 isPass: true,
                 icon: Icons.lock, 
                 ),
                 
                 MyButton(
                  onTab: signUpUser,
                   text:'Sign Up'
                  ),
                  SizedBox(height:height/15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account?",style: TextStyle(fontSize: 16),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> const LoginScreen(),
                          ),
                          );
                        },
                        child: const Text("Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      )
                    ],
                  )
            ],
          ),
        )
      ),
    );
  }
}