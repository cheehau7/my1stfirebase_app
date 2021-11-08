import 'package:flutter/material.dart';


class TextWidget extends StatelessWidget {
  final String? title;
  final TextStyle? textStyle;
  const TextWidget({ Key? key, this.title, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "", style: textStyle,
    );
  }
}