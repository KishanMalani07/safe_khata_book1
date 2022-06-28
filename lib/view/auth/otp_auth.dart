import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_khata_book/view/common/button.dart';
import 'package:safe_khata_book/view/common/common_sizebox.dart';
import 'package:safe_khata_book/view/common/custom_textField.dart';
import 'package:sizer/sizer.dart';

import '../common/app_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController mobileOtp = TextEditingController();
  bool number = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar.appBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(children: [
          Center(
            child: Text(
              "Trusted By Businesses Across India",
              style: TextStyle(
                  fontSize: 10.sp, color: Colors.grey.withOpacity(1.0)),
            ),
          ),
          CommonSizeBox.commonSize(height: 40.sp),
          CommonTextFiled.commonTextFiled(
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              onChange: (value) {},
              textInputType: TextInputType.phone,
              hintText: "enter your mobile number",
              controller: mobileOtp),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: 40,
            ),
            child: CommonButton.commonButton(text: "GET OTP", onTap: () {}),
          )
        ]),
      ),
    );
  }
}
