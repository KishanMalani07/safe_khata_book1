import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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

  static appBarCenterName({@required String? name}) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(name!,
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: ColorPicker.grey,
              fontSize: 25)),
    );
  }

  static appBarCenterNameAndBackArrow({@required String? text}) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        text!,
        style: TextStyle(color: ColorPicker.grey, fontSize: 20.sp),
      ),
      leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorPicker.grey,
          )),
    );
  }
}
