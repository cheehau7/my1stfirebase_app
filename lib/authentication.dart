

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myflutter_exp1/screen/landing_screen.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationHelper with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final uid = _auth.authStateChanges().listen((User? user) => user?.uid);
 // Stream<User> get authState => _auth.authStateChanges().listen((User? user) => user?.uid);
  
  Future signIn({required String email, required String password}) async {
    
    try {

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      return 0;
    }
    on FirebaseAuthException catch (e) {
      print("XXXX#@#@@@#@#@#@#@#@#@3");
      e.message;
    }
  }

  //Sign up
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _auth.currentUser?.uid;
    }
    on FirebaseAuthException catch (e) {
      print("Unable to create new acc");
      e.message;
    }
  }
  //Sign out
  Future signOut() async {
    await _auth.signOut();
    print("Bye~");
  }

  //Get User
  Future getUser() async {
    try {
        _auth.authStateChanges().listen((User? user) { 

        if (user == null) {
          print("User is currently sign out");
        }
        else {
          print("User is signed in");
        }
      });
      return _auth.currentUser?.uid;
    }
    on FirebaseAuthException catch (e) {
      e.message;
    }
  }

  Future writeNewUser({String? uuid}) async {
      
  }
  //Email verify
  Future<bool?> checkEmailVerified({bool isFirst = false}) async {
    final user = _auth.currentUser;
    if (isFirst) {
      user?.sendEmailVerification();  
      signOut();
    }
    else {
      print("Not first");
      await user?.reload();
      if (user != null) {
          if (user.emailVerified) {
            print("Email verified");
        return true;
       // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LandingScreen()));
      }
      else {
        signOut();
        print("Email failed");
        return false;
      }
      }

    }

  }
  //Sign with Google
  Future<UserCredential?> signInWithGoogle() async {

    try {
        //Trigger the authenication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    
    //Obtain
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    //Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    on FirebaseException catch (e) {
      e.message;
      print(e);
    }
    
  }

  // Future<User?> signInWithGoogle({required BuildContext context}) async {
        
  // }
  // Future<UserCredential?> signInWithGoogle()async {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken
  //     );

  //     //Once signed in, return the UserCredential
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
 
}