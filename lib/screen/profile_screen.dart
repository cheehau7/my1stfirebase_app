import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myflutter_exp1/authentication.dart';
import 'package:myflutter_exp1/constants.dart';
import 'package:myflutter_exp1/model/user.dart';
import 'package:myflutter_exp1/provider/movie_provider.dart';
import 'package:myflutter_exp1/widget/custom_text.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'change_name_scree.dart';


class ProfileScreen extends ConsumerWidget {
  User? usr;
  ProfileScreen({Key? key, this.usr}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, cts) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.purple, Colors.indigo])),
                ),
                Center(
                  child: LayoutBuilder(
                    builder: (context, cts2) {
                      return Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: cts.maxHeight * 0.2),
                            height: cts.maxHeight * 0.8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(cts.maxHeight * 0.10),
                                    topRight:
                                        Radius.circular(cts.maxHeight * 0.10))),
                            child: GestureDetector(
                              child: TextWidget(
                                  title: "Change Name",
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )),
                              onTap: () => Navigator.pushNamed(
                                  context, ChangeNameScreen.routeName, arguments: usr),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
