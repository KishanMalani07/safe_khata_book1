import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/button.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/custom_textField.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:safe_khata_book/view/bottom_bar/bottom_bar_screen.dart';
import 'package:sizer/sizer.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class MobileAuthScreen extends StatefulWidget {
  @override
  _MobileAuthScreenState createState() => _MobileAuthScreenState();
}

class _MobileAuthScreenState extends State<MobileAuthScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  bool showLoading = false;

  ///signInWithPhoneAuthCredential
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        DocumentReference doc =
            FirebaseFirestore.instance.collection("contact").doc();

        doc.set({'uid': doc.id, "contact": phoneController.text});
        PreferencesManager.setUid("${doc.id}");
        PreferencesManager.getUid();
        print("PreferencesManager.getUid();${PreferencesManager.getUid()}");

        // if (authCredential?.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBarScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _globalKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("${e.message}"),
        ),
      );
    }
  }

  ///getMobileFormWidget
  getMobileFormWidget(context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Trusted By Businesses Across India",
            style:
                TextStyle(fontSize: 10.sp, color: Colors.grey.withOpacity(1.0)),
          ),
        ),
        CommonSizeBox.commonSize(height: 40.sp),
        CommonTextFiled.commonTextFiled(
            inputFormatters: [LengthLimitingTextInputFormatter(13)],
            onChange: (value) {},
            textInputType: TextInputType.phone,
            hintText: "Please Enter[+91] your mobile number",
            controller: phoneController),
        Spacer(),
        FlatButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });

                PreferencesManager.setMobileNumber("${phoneController.text}");
                print(
                    "getMobileNumber==>${PreferencesManager.getMobileNumber()}");

                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                _globalKey.currentState!.showSnackBar(
                  SnackBar(
                    content: Text("${verificationFailed.message}"),
                  ),
                );
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 40,
            ),
            child: CommonButton.commonButton(
              text: "GET OTP",
              // onTap: () {
              //   print("getotp Click");
              //   if (10 == int.parse(phoneController.text)) {
              //     CommonSnackBar.showSnackBar(msg: "Please enter 10 digit");
              //   }
              // }
            ),
          ),
          // color: Colors.blue,
          // textColor: Colors.white,
        ),
      ],
    );
  }

  ///getOtpFormWidget
  getOtpFormWidget(context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Trusted By Businesses Across India",
            style:
                TextStyle(fontSize: 10.sp, color: Colors.grey.withOpacity(1.0)),
          ),
        ),
        CommonSizeBox.commonSize(height: 40.sp),
        CommonTextFiled.otpTextFiled(
            inputFormatters: [],
            textInputType: TextInputType.number,
            hintText: "Please Enter Otp",
            controller: otpController,
            prefix: SizedBox(
              width: 15,
            )),
        Spacer(),
        FlatButton(
            onPressed: () async {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId!,
                      smsCode: otpController.text);

              signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            child: CommonButton.commonButton(text: "Verify")
            // color: Colors.blue,
            // textColor: Colors.white,
            ),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(),
      key: _globalKey,
      body: Container(
        child: showLoading
            ? Center(child: CircularProgressIndicator())
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
