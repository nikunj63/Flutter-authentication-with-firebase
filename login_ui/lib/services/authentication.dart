import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // for storing data in cloud firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method for signing up a user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Some errors Occurred";
    try {
      if(email.isNotEmpty || password.isNotEmpty || name.isNotEmpty){
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Adding user to our Firestore
      await _firestore.collection("users").doc(credential.user!.uid).set({
        'name': name,
        'email': email,
        'Uid': credential.user!.uid,
      });
      res = 'Successfully';
      }
      
    } catch (e) {
      return e.toString();
    }
    return res;
  }
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
  // for signout
  Future<void> signOut()async{
    await _auth.signOut();
  }
}
