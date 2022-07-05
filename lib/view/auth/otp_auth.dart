import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/view/auth/verify_otp.dart';
import 'package:sizer/sizer.dart';
import '../../common/app_bar.dart';
import '../../common/button.dart';
import '../../common/common_sizebox.dart';
import '../../common/custom_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController mobileOtp = TextEditingController();
  bool number = false;

  ///=====Mobile-Otp=====///
  FirebaseAuth _auth = FirebaseAuth.instance;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  String? verificationId;

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
            child: CommonButton.commonButton(
                text: "GET OTP",
                onTap: () {
                  if (10 == int.parse(mobileOtp.text) ||
                      mobileOtp.text.isNotEmpty) {
                    Get.to(VerifyOtpScreen());
                  }
                }),
          ),
        ]),
      ),
    );
  }
}
