import 'package:flutter/material.dart';
import 'package:login_ui/Widgets/button.dart';
import 'package:login_ui/Widgets/snack_bar.dart';
import 'package:login_ui/Widgets/textfield.dart';
import 'package:login_ui/screens/home_screen.dart';
import 'package:login_ui/screens/signUp_screen.dart';
import 'package:login_ui/services/authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  void despose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }
    void loginUser() async {
  String res = await AuthServices().loginUser(
    email:emailController.text,
    password: passwordController.text,
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
                height: height / 2.7,
              child: Image.asset(
                "assets/images/login.jpeg"
              ),
              ),
              TextfieldInput(
                textEditingController: emailController,
                 hintText: 'Enter your email', 
                 icon: Icons.email, 
                 ),
                 TextfieldInput(
                  isPass: true,
                textEditingController: passwordController,
                 hintText: 'Enter your password', 
                 icon: Icons.lock, 
                 ),
                 const Padding(
                   padding: EdgeInsets.symmetric(horizontal: 35),
                   child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot password ?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                   
                      ),
                    ),
                   ),
                 ),
                 MyButton(
                  onTab: loginUser,
                   text:'Log In'
                  ),
                  SizedBox(height:height/15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't Have an Account?",style: TextStyle(fontSize: 16),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> const SignupScreen(),
                          ),
                          );
                        },
                        child: const Text("SignUp",
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