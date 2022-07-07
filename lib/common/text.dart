import 'package:flutter/cupertino.dart';

class CommonText {
  static simpleText({fontSize, String? text, color, fontWeight}) {
    return Text(
      text!,
      style:
          TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
    );
  }
}
