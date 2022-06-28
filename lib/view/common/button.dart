import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/view/common/color.dart';
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
}
