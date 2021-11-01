import 'package:flutter/material.dart';
import 'package:myflutter_exp1/custom_appbar.dart';



class ChangeNameScreen extends StatelessWidget {
  //const ChangeNameScreen({ Key? key }) : super(key: key);
  static const routeName = '/user-profile/changeNameScreen';
  final TextEditingController _currentName = TextEditingController();
  final TextEditingController _nameNew = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Change Profile Name",
      ),
      body: Container(
        
      ),
    );
  }
}