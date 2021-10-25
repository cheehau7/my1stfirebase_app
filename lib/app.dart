import 'package:flutter/material.dart';
import 'package:myflutter_exp1/provider/auth_provider.dart';
import 'package:myflutter_exp1/screen/landing_screen.dart';
import 'package:myflutter_exp1/screen/login_screen.dart';

class AppScreen extends StatefulWidget {
  
  const AppScreen({ Key? key }) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  dynamic isDone;
  @override
  void initState() {
    isDone = AuthProvider().checkLogin();
    
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    if (isDone == true) {
      return LandingScreen();
    }
    else {
      return LoginScreen();
    }
  }

  // Future<bool> checkLogin() async{
  //    await AuthProvider().checkLogin();
  // }
}