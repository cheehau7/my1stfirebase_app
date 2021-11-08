import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myflutter_exp1/model/user.dart';
import 'package:myflutter_exp1/size_helper.dart';
import 'package:myflutter_exp1/widget/custom_text.dart';
import '../custom_bar.dart';
import 'package:riverpod/riverpod.dart';

final getUserInfo = Provider<User>((ref) => User());

class ChangeNameScreen extends ConsumerWidget {

  ChangeNameScreen({Key? key}) :super(key: key);
  //const ChangeNameScreen({ Key? key }) : super(key: key);
  static const routeName = '/user-profile/changeNameScreen';
  final TextEditingController _currentName = TextEditingController();
  final TextEditingController _nameNew = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   // final usr = ref.watch(getUserInfo);
   final usr = ModalRoute.of(context)?.settings.arguments as User?;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Change Profile Name",
        isBackAvailable: true,
        isTitleCenter: true,
      ),
      body: SafeArea(
        child: Container(
          height: (displayHeight(context) - MediaQuery.of(context).padding.top - kToolbarHeight),
          padding: EdgeInsets.all(8.0),
          width: double.infinity,
          child: Card(
            color: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 TextWidget(title: "Current Name", textStyle: TextStyle(color: Colors.black, fontSize: 20),),
               //  TextWidget(title: usr.name ?? "Unknown",),
                 SelectableText(usr?.name ?? "Unknown",),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}