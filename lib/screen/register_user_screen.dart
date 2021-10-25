import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myflutter_exp1/authentication.dart';
import 'package:myflutter_exp1/main.dart';
import 'package:myflutter_exp1/provider/auth_provider.dart';
import 'package:myflutter_exp1/screen/login_screen.dart';
import 'package:myflutter_exp1/size_helper.dart';
import 'package:uiblock/uiblock.dart';
import 'package:myflutter_exp1/size_helper.dart';

class RegisterUserScreen extends StatelessWidget {
  static const routeName = "/screen/register_user_screen.dart";
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _pass2 = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final fb = FirebaseDatabase.instance.reference();
  String? uuid;

  RegisterUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    final userProfile = fb.child('/userProfile');

    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Center(
        child: Container(
          height: displayHeight(context) -
              MediaQuery.of(context).padding.top -
              kToolbarHeight,
          padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _globalKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Register now!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: displayWidth(context) * 0.06,
                                  color: Colors.indigo),
                            ),
                          ),
                          Column(
                            children: [
                              TextFormField(
                                // autovalidateMode: AutovalidateMode.always,
                                validator: (value) {
                                  if (value == null) {
                                    return "Please enter your full name.";
                                  } else if (value.length < 4) {
                                    return "Name must be in alphabetic";
                                  }
                                  return null;
                                },
                                controller: _fullName,
                                cursorColor: Colors.indigo,
                                decoration: InputDecoration(
                                  labelText: "Full Name",
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              TextFormField(
                                //    autovalidateMode: AutovalidateMode.always,
                                validator: (value) {
                                  if (value == null) {
                                    return "Please enter your email address.";
                                  } else if (value.length < 4) {
                                    return "Invalid email";
                                  }
                                  return null;
                                },
                                controller: _email,
                                decoration: InputDecoration(
                                    labelText: "Email (This is your login ID.)",
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                              TextFormField(
                                //  autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null) {
                                    return "Please enter password.";
                                  } else if (value.length < 4) {
                                    return "Invalid password. Length must be at least more than 4.";
                                  }
                                  return null;
                                },
                                controller: _pass,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                              TextFormField(
                                controller: _pass2,
                                obscureText: true,
                                validator: (value) {
                                  if (_pass2.text != _pass.text) {
                                      return "re-entry password must match with your password";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: "Re-entry Password",
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextButton.icon(
                                      onPressed: () async => signUpWithEmail(
                                          context,
                                          dr: userProfile),
                                      icon: FaIcon(
                                        FontAwesomeIcons.circle,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Sign up',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Divider(
                                    thickness: 1.5,
                                  )),
                                  Text(
                                    ' Or ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Expanded(
                                      child: Divider(
                                    thickness: 1.5,
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.indigo),
                                  child: TextButton.icon(
                                      onPressed: () {
                                        Fluttertoast.showToast(
                                            msg: "Coming soon.",
                                            backgroundColor: Colors.transparent,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM);
                                       // return;
                                        AuthenticationHelper()
                                            .signInWithGoogle();
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.google,
                                        color: Colors.red,
                                      ),
                                      label: Text(
                                        'Sign up with Google',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.indigo),
                                  child: TextButton.icon(
                                      onPressed: () {
                                        Fluttertoast.showToast(
                                            msg: "Coming soon.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM);
                                        return;
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.facebook,
                                      ),
                                      label: Text('Sign up with Facebook',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.indigo),
                                  child: TextButton.icon(
                                      onPressed: () {
                                        Fluttertoast.showToast(
                                            msg: "Coming soon.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM);
                                        return;
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.instagram,
                                        color: Colors.pinkAccent,
                                      ),
                                      label: Text('Sign up with Instagram',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        if (_fullName.text != "" ||
                            _email.text != "" ||
                            _pass.text != "" ||
                            _pass2.text != "") {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  title: Text("Are you sure?"),
                                  content: Text(
                                      "Your register process is undergoing."),
                                  actionsPadding: EdgeInsets.all(10),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Yes, back")),
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text("No")),
                                  ],
                                );
                              });
                        }
                        else {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: Icon(
                        Icons.chevron_left_outlined,
                        color: Colors.black,
                      ),
                      label: Text(
                        "Back",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  signUpWithEmail(BuildContext context, {DatabaseReference? dr}) async {
    // if (_isEmailValid(_email.text)) {
    //   Fluttertoast.showToast(
    //       msg: "Invalid email format",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM);
    //   return;
    // }
    if (!_globalKey.currentState!.validate()) return;
    if (_fullName.text == "") {}
    Fluttertoast.cancel();
    //Check password
    if (_pass.text != _pass2.text) {
      Fluttertoast.showToast(
          msg: "Please check your password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please check your password'),));
    }
    UIBlock.block(context, backgroundColor: Colors.transparent);
    bool isExist = false;
    await AuthenticationHelper()
        .signUp(email: _email.text, password: _pass.text)
        .then((result) {
      if (result != null) {
        uuid = result.toString();
        print("Successfully " + uuid.toString());
        //UIBlock.unblock(context);
        //_showSuccessSignUp(context);
      } else {
        isExist = true;
        UIBlock.unblock(context);
        Fluttertoast.showToast(
            msg: "Something wrong! Try again.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    });
    await AuthenticationHelper().checkEmailVerified(isFirst: true);

    if (!isExist) {
      try {
        await dr
            ?.child(uuid.toString())
            .set({'name': _fullName.text, 'uuid': uuid});
      } on FirebaseException catch (e) {
        e.message;
      }
      UIBlock.unblock(context);
      _showSuccessSignUp(context);
    }
  }

  void _showSuccessSignUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [Icon(Icons.celebration), Text("Successful Sign Up")],
            ),
            content: Text('You can now start to login.'),
            actions: [
              TextButton(
                onPressed: () {
                  _fullName.text = "";
                  _email.text = "";
                  _pass.text = "";
                  _pass2.text = "";

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          );
        });
  }
}
