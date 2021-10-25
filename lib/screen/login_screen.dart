import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myflutter_exp1/authentication.dart';
import 'package:myflutter_exp1/custom_bar.dart';
import 'package:myflutter_exp1/provider/auth_provider.dart';
import 'package:myflutter_exp1/screen/landing_screen.dart';
import 'package:myflutter_exp1/screen/register_user_screen.dart';
import 'package:myflutter_exp1/screen/second_screen.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase?.initializeApp();
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  static const routeName = "/screen/login_screen.dart";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final title = "Please register";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  final failMSG = SnackBar(
    content: Text("Invalid"),
    duration: Duration(seconds: 5),
  );
  bool _isValidate = false;
  FocusNode? femail = FocusNode();
  FocusNode? fpassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: Colors.indigoAccent,
        body: _buildContent());
  }

  Widget _buildContent() {
    return LayoutBuilder(
      builder: (context, constaints) {
        bool _passwordVisible =
            Provider.of<AuthProvider>(context).passwordVisible;
        return Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.redAccent,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              heightFactor: 1.5,
                              child: RichText(
                                text: TextSpan(
                                    text: 'WELCOME,',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: "\nPlease register.",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'LeelawadeeUI',
                                              fontStyle: FontStyle.normal))
                                    ]),
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.indigoAccent),
                                    borderRadius: BorderRadius.circular(20)),
                                label: Icon(
                                  Icons.person,
                                  color: Colors.indigoAccent,
                                ),
                                
                                hintText: "Email"),
                            controller: _emailController,
                            focusNode: femail,
                            onFieldSubmitted: (t) {
                              femail!.unfocus();
                              FocusScope.of(context).requestFocus(fpassword);
                            },
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (femail!.hasFocus) return null;
                              if (value == null) {
                                print('enter');
                                return 'Please enter your ID';
                              } else if (value.length < 4) {
                                return 'Please enter valid ID';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            focusNode: fpassword,
                            onFieldSubmitted: (t) {
                              fpassword!.unfocus();
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.indigo),
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  //color: Colors.grey,

                                  onPressed: () {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .passwordVisibility();
                                  },
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                label: Icon(
                                  Icons.lock,
                                  color: Colors.indigoAccent,
                                )),
                            controller: _passwordController,
                            obscureText: !_passwordVisible,
                            validator: (value) {
                               if (fpassword!.hasFocus) return null;
                               if (femail!.hasFocus && value == null) return null; 
                              if (value == null) {
                                print('enter');
                                return 'Please enter your password';
                              } else if (value.length < 4) {
                                return 'Please enter a valid password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Dont have an account? ',
                                      style: TextStyle(color: Colors.grey[700]),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Sign up with email now.",
                                            style:
                                                TextStyle(color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print("Click register");
                                                _emailController.text = "";
                                                _passwordController.text = "";
                                                _formKey.currentState
                                                    ?.deactivate();
                                                Navigator.pushNamed(
                                                    context,
                                                    RegisterUserScreen
                                                        .routeName);
                                              })
                                      ]),
                                ),
                              ),
                              MaterialButton(
                                color: Colors.indigo,
                                onPressed: () async {
                                  UIBlock.block(context);
                                  if (!_formKey.currentState!.validate()) {
                                    UIBlock.unblock(context);
                                    return;
                                  }
                                  print(
                                      "NAME AND PASS : ${_emailController.text} \n ${_passwordController.text}");
                                  bool? isVerified;
                                  // if (isVerified != null && !isVerified) {
                                  //     showDialog(context: context, builder: (context) => AlertDialog(
                                  //       title: Text("Please verify"),
                                  //       content: Text("Email verification had been sent to your email."),
                                  //       actions: [
                                  //         TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Ok')),
                                  //         TextButton(onPressed: () async {
                                  //           UIBlock.block(context);
                                  //           await AuthenticationHelper().checkEmailVerified(isFirst: true);
                                  //           UIBlock.unblock(context);
                                  //         }, child: Text('Resent email verfication.', style: TextStyle(fontWeight: FontWeight.bold)))
                                  //       ],
                                  //     ));
                                  //     return;
                                  // }
                                  AuthenticationHelper()
                                      .signIn(
                                          email: _emailController.text,
                                          password: _passwordController.text)
                                      .then((result) async {
                                    if (result != null) {
                                      isVerified = await AuthenticationHelper()
                                          .checkEmailVerified();
                                      if (isVerified != null &&
                                          isVerified == false) {
                                        //  UIBlock.unblock(context);
                                        print("no verify");

                                        await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.angry,
                                                        color: Colors.red,
                                                      ),
                                                      Text("Please verify"),
                                                    ],
                                                  ),
                                                  content: Text(
                                                      "Email verification had been sent to your email."),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text('Ok')),
                                                    TextButton(
                                                        onPressed: () async {
                                                          UIBlock.block(
                                                              context);
                                                          Future.delayed(
                                                              const Duration(
                                                                  seconds: 3),
                                                              () {
                                                            UIBlock.unblock(
                                                                context);
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "New email verfication had been sent.",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM);
                                                            _emailController
                                                                .text = "";
                                                            _passwordController
                                                                .text = "";
                                                            _formKey
                                                                .currentState
                                                                ?.deactivate();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });
                                                          await AuthenticationHelper()
                                                              .checkEmailVerified(
                                                                  isFirst:
                                                                      true);
                                                        },
                                                        child: Text(
                                                            'Resent email verfication.',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)))
                                                  ],
                                                ));
                                        UIBlock.unblock(context);
                                        return;
                                      }
                                      print("yessss ${result}");
                                      UIBlock.unblock(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Success"),
                                      ));
                                      Navigator.pushNamed(
                                        context,
                                        LandingScreen.routeName,
                                      );
                                      //_messangerKey.currentState?.showSnackBar(SnackBar(content: Text("Successfully login: "+result.toString())));
                                    } else {
                                      print("ssss");
                                      //   ScaffoldMessenger.of(context).showSnackBar(failMSG);
                                      _emailController.text = "";
                                      _passwordController.text = "";
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                title: Text('Invalid'),
                                                content:
                                                    Text("Please try again."),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        UIBlock.unblock(
                                                            context);
                                                      },
                                                      child: Text("Ok"))
                                                ],
                                              ));
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.security,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Image.asset("assets/images/people1.jpg")
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: constaints.maxHeight * 0.2,
                  child: FlutterLogo(
                    size: 120,
                    curve: Curves.slowMiddle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
