import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './app.dart';
import './authentication.dart';
import 'package:myflutter_exp1/provider/auth_provider.dart';
import 'package:myflutter_exp1/screen/landing_screen.dart';
import 'package:myflutter_exp1/screen/login_screen.dart';
import 'package:myflutter_exp1/screen/register_user_screen.dart';
import 'package:myflutter_exp1/screen/second_screen.dart';
import 'package:provider/provider.dart';
import 'screen/user_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase?.initializeApp();
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationHelper> (create: (ctx) => AuthenticationHelper(),),
        ChangeNotifierProvider<AuthProvider> (create: (ctx) => AuthProvider(),)
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo,
           primarySwatch: Colors.indigo,
          // inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(20),
          //   borderSide: BorderSide())),
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.indigo),
            bodyText2: TextStyle(color: Colors.indigo)
          ).apply(
            bodyColor: Colors.indigo,
            displayColor: Colors.indigo
          )
        ),
        title: "Hew App",
        home: FutureBuilder<bool>(
          future: AuthProvider().checkLogin(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == false) {
              print("Is false");
              return LoginScreen();
            }
            else {
              return LandingScreen();
            }
            }
            else {
              return LoginScreen();
            }
          },
        ),
        routes: {
          SecondScreen.routeName: (ctx) => SecondScreen(),
          UserScreen.routeName: (ctx) => UserScreen(),
          RegisterUserScreen.routeName: (ctx) => RegisterUserScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          LandingScreen.routeName: (ctx) => LandingScreen(),
        }
      ),
    );
  }


 
}

