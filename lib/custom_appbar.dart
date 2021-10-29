import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? title;
  final List <Widget>? actions;

  CustomAppBar({this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? "Unknown"
      ),
      actions: actions,
      iconTheme: IconThemeData(color: Colors.white),

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}