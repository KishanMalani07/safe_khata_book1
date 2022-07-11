import 'package:flutter/cupertino.dart';

class CommonText {
  static simpleText(
      {fontSize, String? text, color, fontWeight, textAlign, overflow}) {
    return Text(
      text!,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
