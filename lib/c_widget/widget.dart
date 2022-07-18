import 'package:flutter/material.dart';

showListText(
    {@required String? text,
    Color? color,
    maxline,
    overflow,
    fontSize,
    fontWeight,
    dynamic ontap}) {
  return InkWell(
    onTap: ontap,
    child: Text(
      "${text ?? 0}",
      overflow: overflow,
      maxLines: maxline,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    ),
  );
}
