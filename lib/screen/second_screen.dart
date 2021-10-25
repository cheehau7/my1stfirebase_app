import 'package:flutter/material.dart';
import 'package:myflutter_exp1/screen/user_screen.dart';


class SecondScreen extends StatelessWidget {
  const SecondScreen({ Key? key }) : super(key: key);
  static const routeName = '/screen/second_screen.dart';
  @override
  Widget build(BuildContext context) {
    var isOrien = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: SafeArea(
        child: Center(
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SSS"),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, UserScreen.routeName),
                  child: Text("Back"),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}