import 'package:flutter/material.dart';

showListText(
    {@required String? text,
    Color? color,
    maxline,
    fontSize,
    fontWeight,
    dynamic ontap}) {
  return InkWell(
    onTap: ontap,
    child: Text(
      "${text ?? 0}",
      maxLines: maxline,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    ),
  );
}
