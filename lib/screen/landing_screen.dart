import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myflutter_exp1/authentication.dart';
import 'package:myflutter_exp1/main.dart';
import 'package:myflutter_exp1/model/user.dart';
import 'package:myflutter_exp1/provider/auth_provider.dart';
import 'package:myflutter_exp1/screen/login_screen.dart';
import 'package:uiblock/uiblock.dart';

class LandingScreen extends StatefulWidget {
  final User? user;
  final fb = FirebaseDatabase.instance.reference();
 

  LandingScreen({Key? key, this.user}) : super(key: key);
  static const String routeName = "/screen/landing_screen.dart";
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  User? usr;
  void _activateListeners() async {
    final getUUID =
        await AuthenticationHelper().getUser().then((value) => value);
    print("print uuid ${getUUID}");
    fb.child('userProfile/${getUUID}').onValue.listen((event) {
      print("hehe " + event.snapshot.value.toString());
      final mydata = Map<String, dynamic>.from(event.snapshot.value);
      final name = mydata['name'] as String;
      print("name: ${name}");
      setState(() {
        usr = User(name: name, uuid: getUUID);
      });
    });
    // if (getUUID == null) return;
    //  var q = fb.child('userProfile/${getUUID}');
    //  q.once().then((value) => {
    //    print("ttyy=> " + value.value.toString())
    //  });
  }

  @override
  void initState() {
    print("Try enter");
    _activateListeners();
    //init();
    super.initState();
  }

  Future<void> init() async {
    final getUUID =
        await AuthenticationHelper().getUser().then((value) => value);
    if (getUUID == null) {
      return;
    }
    final query = fb.orderByChild("uuid").equalTo(getUUID);

    //  niceMap.forEach((key, value) {print("Key: ${key} \nValue: ${value}");});
  }

  @override
  Widget build(BuildContext context) {
     final TextEditingController _name = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text('Reading data'),
          backgroundColor: Colors.indigoAccent,
          centerTitle: true,
          elevation: 5,
          automaticallyImplyLeading: false,
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, cts) {
            return Column(
              children: [
                Container(
                alignment: Alignment.center,
                height: cts.maxHeight * 0.8,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: RichText(
                              text: TextSpan(
                                text: 'Welcome back,\n',
                                style: TextStyle(color: Colors.black, fontSize: 30),
                                children: <TextSpan> [
                                  TextSpan(text: (usr?.name)!.toUpperCase(), style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                                ]
                              ),
                                                    ),
                            ),
                          Flexible(child: Text('Time: ${(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))}', style: TextStyle(color: Colors.black, fontSize: 25,)))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text("Current name: ${usr?.name}",style: TextStyle(fontSize: 20),),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Enter your new name"
                              ),
                              controller: _name,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                           decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.greenAccent[700]),
                          child: TextButton(onPressed: () {
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                  title: Text("Confirm Change"),
                                  content: Text("Click yes will change your current name"),
                                  actions: [
                                    TextButton(onPressed: () async{
                                      if (_name.text == null || _name.text == "") {
                                        Fluttertoast.showToast(msg: "Invalid name provded", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
                                        Navigator.of(context).pop();
                                        return;
                                      }
                                      UIBlock.block(context, loadingTextWidget: Container(
                                        padding: EdgeInsets.all(15),
                                        color: Colors.white,
                                         child: Text('Changing your name...'),));
                                      await Future.delayed(Duration(seconds: 3));
                                      try {
                                        await fb.child('userProfile/${usr?.uuid}').update({'name': _name.text}).then((value) => {
                                        
                                        });
                                        setState(() {
                                          usr?.name = _name.text;
                                        });
                                      }
                                      on FirebaseException catch (e) {
                                        e.message;
                                      }
                              
                              
                                      UIBlock.unblock(context);
                                      Navigator.of(context).pop();
                                      Fluttertoast.showToast(msg: "Change successfully.", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
                                    }, child: Text('Yes')),
                                    TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('No'))
                                  ],
                              );
                            });
                          }, child: Text('Confirm change', style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.indigoAccent),
                          child: TextButton.icon(
                              onPressed: () {
                                print("Enter signout session");
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)),
                                        title: Column(
                                          children: [
                                            Icon(
                                              Icons.warning_amber_outlined,
                                              color: Colors.redAccent,
                                            ),
                                            Text("你确定吗")
                                          ],
                                        ),
                                        content: Text('Do you want to sign out?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                UIBlock.block(context);
                                                await Future.delayed(
                                                    Duration(seconds: 3));
                                                UIBlock.unblock(context);
                                                Fluttertoast.showToast(
                                                    msg: "You have signed out.",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM);
                                                AuthenticationHelper()
                                                    .signOut()
                                                    .then((result) => {});
                                                Navigator.pushNamed(
                                                    context, LoginScreen.routeName);
                                              },
                                              child: Text(
                                                '是的',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('不'))
                                        ],
                                      );
                                    });
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.signOutAlt,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Sign out",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
             
              ],
            );
          },
        ));
  }
}
