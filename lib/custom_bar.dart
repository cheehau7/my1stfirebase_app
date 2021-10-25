import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  final String? title;
  final bool? isBackAvailable;
  
  CustomAppBar({this.title, this.isBackAvailable});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title ?? ""),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: isBackAvailable ?? false,
        // leading: const FlutterLogo(
        //   size: 100,
        //   style: FlutterLogoStyle.markOnly,
        //   curve: Curves.bounceIn,
          
        // ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}