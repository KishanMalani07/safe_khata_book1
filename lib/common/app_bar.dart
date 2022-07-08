import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/text.dart';
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
        overflow: TextOverflow.ellipsis,
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

  static customerAppData() {
    return PreferredSize(
        child: Container(
          width: Get.width,
          height: Get.height * 0.11,
          color: ColorPicker.grey,
          // color: ColorPicker.lightContainerColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 28, right: 15),
            child: Row(children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              CommonSizeBox.commonSize(width: 10.sp),
              Container(
                height: 35.sp,
                width: 35.sp,
                decoration:
                    BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
              ),
              CommonSizeBox.commonSize(width: 10.sp),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 8),
                child: Column(
                  children: [
                    CommonText.simpleText(
                        text: "Name",
                        fontSize: 15.sp,
                        color: ColorPicker.whiteColor,
                        fontWeight: FontWeight.bold),
                    CommonText.simpleText(
                        text: "Sub Title",
                        fontSize: 10.sp,
                        color: ColorPicker.whiteColor)
                  ],
                ),
              ),
              Spacer(),
              Icon(
                Icons.more_vert,
                color: ColorPicker.whiteColor,
              )
            ]),
          ),
        ),
        preferredSize: Size.fromHeight(80.sp));
  }
}
