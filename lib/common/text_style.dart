import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/parties/calander.dart';

class FontTextStyle {
  static TextStyle kWhite17W400Roboto = TextStyle(
    color: Colors.white,
    fontSize: Get.height * 0.021,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
  );
  static TextStyle kWhite18BoldRoboto = TextStyle(
    color: Colors.white,
    fontSize: Get.height * 0.024,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
  );
  static TextStyle kWhite17BoldRoboto = TextStyle(
    color: Colors.white,
    fontSize: Get.height * 0.018,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
  );

  static TextStyle kLightGray16W300Roboto = TextStyle(
      color: ColorUtils.kLightGray,
      fontSize: Get.height * 0.018,
      fontWeight: FontWeight.w300,
      fontFamily: 'Roboto');

  static TextStyle kWhite20BoldRoboto = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: Get.height * .02);

  static TextStyle kBlack18w600Roboto = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: Get.width * .038);
}
