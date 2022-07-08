import 'package:flutter/cupertino.dart';

class CommonText {
  static simpleText({fontSize, String? text, color, fontWeight, textAlign}) {
    return Text(
      text!,
      textAlign: textAlign,
      style:
          TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
    );
  }
}
