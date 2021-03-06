import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/color.dart';

import 'package:sizer/sizer.dart';

class CommonTextFiled {
  static commonTextFiled(
      {String? hintText,
      TextEditingController? controller,
      TextInputType? textInputType,
      dynamic onChange,
      required List<TextInputFormatter> inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        style: TextStyle(
          color: ColorPicker.grey,
          fontWeight: FontWeight.w400,
        ),
        onChanged: onChange,
        controller: controller,
        cursorColor: ColorPicker.grey,
        decoration: InputDecoration(
          isCollapsed: true,
          focusColor: ColorPicker.grey,
          hoverColor: ColorPicker.testFiledHintBorder,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPicker.testFiledHintBorder),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPicker.testFiledHintBorder),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPicker.testFiledHintBorder),
          ),
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
          hintStyle: TextStyle(
            color: ColorPicker.grey,
            fontWeight: FontWeight.w400,
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }

  static otpTextFiled(
      {String? hintText,
      TextEditingController? controller,
      TextInputType? textInputType,
      dynamic onChange,
      Widget? prefix,
      Widget? suffixIcon,
      required List<TextInputFormatter> inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        style: TextStyle(
          color: ColorPicker.grey,
          fontWeight: FontWeight.w400,
        ),
        onChanged: onChange,
        controller: controller,
        cursorColor: ColorPicker.grey,
        decoration: InputDecoration(
          prefixStyle: TextStyle(),
          prefix: prefix,
          isCollapsed: true,
          focusColor: ColorPicker.black,
          hoverColor: ColorPicker.testFiledHintBorder,
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorPicker.testFiledHintBorder, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorPicker.testFiledHintBorder, width: 2),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorPicker.testFiledHintBorder,
                width: 2,
                style: BorderStyle.solid),
          ),
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
          hintStyle: TextStyle(
            color: ColorPicker.black,
            fontWeight: FontWeight.w400,
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }

  static entryTextFiled(
      {String? hintText,
      TextEditingController? controller,
      TextInputType? textInputType,
      dynamic onChange,
      Widget? prefixIcon,
      Widget? prefix,
      Widget? suffixIcon,
      required List<TextInputFormatter> inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        style: TextStyle(
          color: ColorPicker.grey,
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
        ),
        onChanged: onChange,
        controller: controller,
        cursorColor: ColorPicker.grey,
        decoration: InputDecoration(
          prefixStyle: TextStyle(color: ColorPicker.grey),
          prefixIcon: prefixIcon,
          prefix: prefix,
          suffix: suffixIcon,
          suffixStyle: TextStyle(color: ColorPicker.grey),
          isCollapsed: true,
          focusColor: ColorPicker.grey,
          hoverColor: ColorPicker.testFiledHintBorder,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
          hintStyle: TextStyle(
            color: ColorPicker.grey,
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }

  static messageTextFiled(
      {String? hintText,
      TextEditingController? controller,
      TextInputType? textInputType,
      dynamic onChange,
      Widget? prefixIcon,
      Widget? prefix,
      Widget? suffixIcon,
      required List<TextInputFormatter> inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        style: TextStyle(
          color: ColorPicker.grey,
          decoration: TextDecoration.none,
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
        ),
        onChanged: onChange,
        controller: controller,
        cursorColor: ColorPicker.grey,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorPicker.testFiledHintBorder, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorPicker.testFiledHintBorder, width: 2),
          ),
          // border: OutlineInputBorder(
          //   borderSide: BorderSide(
          //       color: ColorPicker.testFiledHintBorder,
          //       width: 2,
          //       style: BorderStyle.solid),
          // ),
          border: InputBorder.none,
          prefixStyle: TextStyle(color: ColorPicker.grey),
          prefixIcon: prefixIcon,
          prefix: prefix,
          suffix: suffixIcon,
          suffixStyle: TextStyle(
            color: ColorPicker.grey,
          ),
          isCollapsed: true,
          focusColor: ColorPicker.grey,
          hoverColor: ColorPicker.testFiledHintBorder,
          // enabledBorder: InputBorder.none,
          // focusedBorder: InputBorder.none,
          // border: InputBorder.none,
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
          hintStyle: TextStyle(
            color: ColorPicker.grey,
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
