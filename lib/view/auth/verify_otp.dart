import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/button.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/custom_textField.dart';
import 'package:sizer/sizer.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otp = TextEditingController();

  @override
  void initState() {
    decrementCounter();
    // TODO: implement initState
    super.initState();
  }

  var isTime = 25;
  Timer? timer;

  void decrementCounter() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (isTime > 0) {
        // print("====>>>isTime$isTime");
        setState(() {
          isTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBarCenterName(name: "SafeKhataBook"),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 60.sp,
          width: Get.width,
          color: ColorPicker.lightContainerColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(children: [
              Icon(
                Icons.message,
                size: 30,
                color: ColorPicker.grey,
              ),
              CommonSizeBox.commonSize(width: 10.sp),
              Text(
                "OTP sent to +91 1234567890",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorPicker.grey,
                    fontWeight: FontWeight.w900),
              )
            ]),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: CommonTextFiled.otpTextFiled(
              prefixIcon: SizedBox(
                width: 15,
              ),
              controller: otp,
              inputFormatters: [LengthLimitingTextInputFormatter(6)],
              textInputType: TextInputType.number,
              hintText: "Enter 6 digit OTP"),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: Text(
            "Resend OTP in $isTime seconds",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 10.sp,
                color: ColorPicker.grey,
                fontWeight: FontWeight.w500),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 50, left: 10, right: 10),
          child: CommonButton.commonButton(text: "SUBMIT", onTap: () {}),
        )
      ]),
    );
  }
}
