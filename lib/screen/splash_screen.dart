import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      title: "Splash Screen",
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              FlutterLogo(),
              Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  value: 0.8,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}