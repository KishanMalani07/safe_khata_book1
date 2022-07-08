import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:sizer/sizer.dart';

class CommonButton {
  static commonButton({String? text, dynamic onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.06,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPicker.grey,
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(color: ColorPicker.whiteColor, fontSize: 15.sp),
          ),
        ),
      ),
    );
  }

  static commonYouGaveButton({String? text, dynamic onTap, color}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.055,
        width: Get.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(color: ColorPicker.whiteColor, fontSize: 13.sp),
          ),
        ),
      ),
    );
  }

  static commonWithIconButton(
      {String? text, dynamic onTap, color, Icon? icon}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.055,
        width: Get.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            Text(
              text!,
              style: TextStyle(color: ColorPicker.whiteColor, fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }
}
