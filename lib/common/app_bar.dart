import 'package:flutter/material.dart';

import 'color.dart';

class CommonAppBar {
  static appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text("SafeKhataBook",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: ColorPicker.grey,
              fontSize: 25)),
    );
  }
}
