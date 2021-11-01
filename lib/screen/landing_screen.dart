import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myflutter_exp1/authentication.dart';
import 'package:myflutter_exp1/constants.dart';
import 'package:myflutter_exp1/custom_bar.dart';
import 'package:myflutter_exp1/db_service.dart';
import 'package:myflutter_exp1/main.dart';
import 'package:myflutter_exp1/model/user.dart';
import 'package:myflutter_exp1/provider/auth_provider.dart';
import 'package:myflutter_exp1/provider/fire_storage_service.dart';
import 'package:myflutter_exp1/screen/login_screen.dart';
import 'package:myflutter_exp1/screen/movie_screen.dart';
import 'package:myflutter_exp1/screen/profile_screen.dart';
import 'package:myflutter_exp1/size_helper.dart';
import 'package:uiblock/uiblock.dart';
import 'package:myflutter_exp1/model/clock.dart';

final steam = Stream.fromIterable([20, 42]);
final streamProvider = StreamProvider<int>((ref) {
  return Stream.fromIterable([36, 50]);
});



class LandingScreen extends ConsumerStatefulWidget {
  final User? user;
  final fb = DBService().getFB;
  LandingScreen({Key? key, this.user}) : super(key: key);
  static const String routeName = "/screen/landing_screen.dart";

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  User? usr;
  User? usr2;
  
  int selectedIndex = 0;
  List<Widget>? tabs;

  void _activateListeners() async {
    final getUUID =
        await AuthenticationHelper().getUser().then((value) => value);
    print("print uuid ${getUUID}");
    fb.child('userProfile/${getUUID}').onValue.listen((event) {
      print("hehe " + event.snapshot.value.toString());
      final mydata = Map<String, dynamic>.from(event.snapshot.value);
      // final name = mydata['name'] as String;
      // final age = (mydata['age'] ?? '0') as String;
      usr2 = User.fromJson(mydata);
      print("name: ${name}");
      setState(() {
        //  usr = User(name: name, uuid: getUUID, age: int.parse(age));
      });
    });
  }

  @override
  void initState() {
    print("Try enter");
    _activateListeners();
    super.initState();
    tabs = [MovieScreen(), ProfileScreen(usr: usr2,)];
    //init();
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

  void _onTabItem(int index) {
    print(index);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _name = TextEditingController();
    final TextEditingController _age = TextEditingController();
    final streamAsyncValue = ref.watch(streamProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //  appBar: CustomAppBar(title: "Movie", isBackAvailable: false, ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: _onTabItem,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user), label: 'Profile'),
          ],
        ),
        body: tabs![selectedIndex],
        // body: LayoutBuilder(
        //   builder: (BuildContext context, cts) {
        //     return Stack(
        //       children: [
        //         Container(
        //           alignment: Alignment.topCenter,
        //           padding: EdgeInsets.all(10),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: [
        //               Flexible(
        //                 child: Padding(
        //                   padding: const EdgeInsets.only(top: 25.0),
        //                   child: RichText(
        //                     text: TextSpan(
        //                         text: 'Welcome back,\n',
        //                         style: TextStyle(
        //                             color: Colors.white, fontSize: 30),
        //                         children: <TextSpan>[
        //                           TextSpan(
        //                               text: (usr?.name)!.toUpperCase(),
        //                               style: TextStyle(
        //                                   color: Colors.white,
        //                                   fontWeight: FontWeight.bold))
        //                         ]),
        //                   ),
        //                 ),
        //               ),
        //               Flexible(
        //                 child: Padding(
        //                   padding: EdgeInsets.only(top: 25),
        //                   child: StreamBuilder(
        //                     stream: Clock().clock(),
        //                     builder: (context, AsyncSnapshot<String> snapshot) {
        //                       if (snapshot.connectionState ==
        //                           ConnectionState.waiting) {
        //                         return CircularProgressIndicator();
        //                       }
        //                       return Text(
        //                         snapshot.data.toString(),
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                           fontSize: 25,
        //                         ),
        //                       );
        //                     },
        //                   ),
        //                 ),
        //               )
        //               // Flexible(child: streamAsyncValue.when(data: (data) => Text('Value: ${data}'), error: (e, st, previous) => Text('Error ${e}'), loading: (previous) => CircularProgressIndicator()))
        //               // Flexible(child: Text('Time: ${(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))}', style: TextStyle(color: Colors.black, fontSize: 25,)))
        //             ],
        //           ),
        //           height: displaySize(context).height -
        //               MediaQuery.of(context).padding.top -
        //               kToolbarHeight,
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //               gradient: LinearGradient(
        //                   begin: Alignment.centerLeft,
        //                   end: Alignment.centerRight,
        //                   colors: [Colors.purple, Colors.indigoAccent])),
        //         ),
        //         Container(
    
        //           width: double.infinity,
        //           margin: const EdgeInsets.only(top: 240),
        //           padding: EdgeInsets.only(top: 30),
        //           height: displaySize(context).height * 0.74,
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.only(
        //                   topLeft: Radius.circular(60),
        //                   topRight: Radius.circular(60))),
        //           child: Column(
        //             children: [
        //               Container(
        //                 alignment: Alignment.center,
        //                 //  height: cts.maxHeight * 1,
        //                 padding: EdgeInsets.all(10),
        //                 child: SingleChildScrollView(
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       SizedBox(
        //                         height: 10,
        //                       ),
        //                       Container(
        //                         padding: EdgeInsets.all(10),
        //                         alignment: Alignment.center,
        //                         child: Column(
        //                           children: [
        //                             Text(
        //                               "Current name: ${usr?.name}",
        //                               style: TextStyle(fontSize: 20),
        //                             ),
        //                             Text(
        //                               "Age: ${usr?.age ?? "Unknown"}",
        //                               style: TextStyle(fontSize: 20),
        //                             ),
        //                             TextField(
        //                               decoration: InputDecoration(
        //                                   labelText: "Enter your new name"),
        //                               controller: _name,
        //                             ),
        //                             TextField(
        //                               decoration: InputDecoration(
        //                                   labelText: "Add your age"),
        //                               controller: _age,
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                       Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Container(
        //                           width: double.infinity,
        //                           decoration: BoxDecoration(
    
        //                               borderRadius: BorderRadius.circular(10),
        //                               color: Colors.greenAccent[700]),
        //                           child: TextButton(
        //                               onPressed: () {
        //                                 showDialog(
        //                                     context: context,
        //                                     builder: (context) {
        //                                       return AlertDialog(
        //                                         title: Text("Confirm Change"),
        //                                         content: Text(
        //                                             "Click yes will change your current info"),
        //                                         actions: [
        //                                           TextButton(
        //                                               onPressed: () async {
        //                                                 if (_name.text ==
        //                                                         null ||
        //                                                     _name.text == "") {
        //                                                   Fluttertoast.showToast(
        //                                                       msg:
        //                                                           "Invalid name provded",
        //                                                       toastLength: Toast
        //                                                           .LENGTH_SHORT,
        //                                                       gravity:
        //                                                           ToastGravity
        //                                                               .BOTTOM);
        //                                                   Navigator.of(context)
        //                                                       .pop();
        //                                                   return;
        //                                                 }
        //                                                 if (_age.text != null &&
        //                                                     _age.text != "" &&
        //                                                     int.tryParse(_age
        //                                                             .text) ==
        //                                                         null) {
        //                                                   Fluttertoast.showToast(
        //                                                       msg:
        //                                                           "Age must be in number",
        //                                                       toastLength: Toast
        //                                                           .LENGTH_SHORT,
        //                                                       gravity:
        //                                                           ToastGravity
        //                                                               .BOTTOM);
        //                                                   Navigator.of(context)
        //                                                       .pop();
        //                                                   return;
        //                                                 }
        //                                                 UIBlock.block(
        //                                                   context,
        //                                                   loadingTextWidget:
        //                                                       Container(
        //                                                     padding:
        //                                                         EdgeInsets.all(
        //                                                             20),
        //                                                     decoration: BoxDecoration(
        //                                                         color: Colors
        //                                                             .transparent,
        //                                                         borderRadius:
        //                                                             BorderRadius
        //                                                                 .circular(
        //                                                                     50)),
        //                                                     child: Text(
        //                                                       'Changing your profile info...',
        //                                                       style: TextStyle(
        //                                                           color: Colors
        //                                                               .indigo),
        //                                                     ),
        //                                                   ),
        //                                                 );
        //                                                 await Future.delayed(
        //                                                     Duration(
        //                                                         seconds: 3));
        //                                                 // make age optional update
        //                                                 if (_age.text == "")
        //                                                   _age.text = (usr?.age)
        //                                                       .toString();
        //                                                 try {
        //                                                   await fb
        //                                                       .child(
        //                                                           'userProfile/${usr?.uuid}')
        //                                                       .update({
        //                                                     'name': _name.text,
        //                                                     'age': _age.text
        //                                                   }).then((value) =>
        //                                                           {});
        //                                                   setState(() {
        //                                                     usr?.name =
        //                                                         _name.text;
        //                                                     usr?.age =
        //                                                         int.parse(
        //                                                             _age.text);
        //                                                   });
        //                                                 } on FirebaseException catch (e) {
        //                                                   e.message;
        //                                                 }
    
        //                                                 UIBlock.unblock(
        //                                                     context);
        //                                                 Navigator.of(context)
        //                                                     .pop();
        //                                                 Fluttertoast.showToast(
        //                                                     msg:
        //                                                         "Change successfully.",
        //                                                     toastLength: Toast
        //                                                         .LENGTH_SHORT,
        //                                                     gravity:
        //                                                         ToastGravity
        //                                                             .BOTTOM);
        //                                               },
        //                                               child: Text('Yes')),
        //                                           TextButton(
        //                                               onPressed: () =>
        //                                                   Navigator.of(context)
        //                                                       .pop(),
        //                                               child: Text('No'))
        //                                         ],
        //                                       );
        //                                     });
        //                               },
        //                               child: Text(
        //                                 'Confirm change',
        //                                 style: TextStyle(color: Colors.white),
        //                               )),
        //                         ),
        //                       ),
        //                       Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Container(
        //                           width: double.infinity,
        //                           decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(10),
        //                               color: Colors.indigoAccent),
        //                           child: TextButton.icon(
        //                               onPressed: () {
        //                                 print("Enter signout session");
        //                                 showDialog(
        //                                     context: context,
        //                                     builder: (context) {
        //                                       return AlertDialog(
        //                                         shape: RoundedRectangleBorder(
        //                                             borderRadius:
        //                                                 BorderRadius.circular(
        //                                                     15)),
        //                                         title: Column(
        //                                           children: [
        //                                             Icon(
        //                                               Icons
        //                                                   .warning_amber_outlined,
        //                                               color: Colors.redAccent,
        //                                             ),
        //                                             Text("你确定吗")
        //                                           ],
        //                                         ),
        //                                         content: Text(
        //                                             'Do you want to sign out?'),
        //                                         actions: [
        //                                           TextButton(
        //                                               onPressed: () async {
        //                                                 UIBlock.block(context);
        //                                                 await Future.delayed(
        //                                                     Duration(
        //                                                         seconds: 3));
        //                                                 UIBlock.unblock(
        //                                                     context);
        //                                                 Fluttertoast.showToast(
        //                                                     msg:
        //                                                         "You have signed out.",
        //                                                     toastLength: Toast
        //                                                         .LENGTH_SHORT,
        //                                                     gravity:
        //                                                         ToastGravity
        //                                                             .BOTTOM);
        //                                                 AuthenticationHelper()
        //                                                     .signOut()
        //                                                     .then(
        //                                                         (result) => {});
        //                                                 Navigator.pushNamed(
        //                                                     context,
        //                                                     LoginScreen
        //                                                         .routeName);
        //                                               },
        //                                               child: Text(
        //                                                 '是的',
        //                                                 style: TextStyle(
        //                                                     fontWeight:
        //                                                         FontWeight
        //                                                             .bold),
        //                                               )),
        //                                           TextButton(
        //                                               onPressed: () {
        //                                                 Navigator.of(context)
        //                                                     .pop();
        //                                               },
        //                                               child: Text('不'))
        //                                         ],
        //                                       );
        //                                     });
        //                               },
        //                               icon: FaIcon(
        //                                 FontAwesomeIcons.signOutAlt,
        //                                 color: Colors.white,
        //                               ),
        //                               label: Text(
        //                                 "Sign out",
        //                                 style: TextStyle(color: Colors.white),
        //                               )),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Positioned(
        //           top: displayWidth(context) * 0.32,
        //           left: displayWidth(context) * 0.38,
    
        //           //  right: 150,
        //           child: Material(
        //             borderRadius: BorderRadius.circular(25.0),
        //             color: Colors.transparent,
        //             child: Container(
        //               padding: EdgeInsets.all(5),
        //               width: displaySize(context).width * 0.30,
        //               height: displaySize(context).height * 0.15,
        //               child: FutureBuilder(
        //                 future: _getImage(context, "person1.png"),
        //                 builder: (context, AsyncSnapshot<Widget> snapshot) {
        //                   if (snapshot.connectionState ==
        //                       ConnectionState.done) {
        //                     return Container(
        //                       child: snapshot.data,
        //                     );
        //                   } else {
        //                     return CircularProgressIndicator();
        //                   }
        //                   return Container();
        //                 },
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     );
        //   },
        // )
      ),
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    late Image image;
    await FireStorageService.loadImage(context, imageName)?.then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return image;
  }
}
