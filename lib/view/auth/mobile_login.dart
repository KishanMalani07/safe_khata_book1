import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/button.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/custom_textField.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:safe_khata_book/view/bottom_bar/bottom_bar_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class MobileAuthScreen extends StatefulWidget {
  @override
  _MobileAuthScreenState createState() => _MobileAuthScreenState();
}

class _MobileAuthScreenState extends State<MobileAuthScreen> {
  ///==========FutureMethod======///

  File? _image;
  final picker = ImagePicker();

  final ImagePicker _picker = ImagePicker();

  Future getGalleryImage() async {
    var imageGa = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (imageGa != null) {
        _image = File(imageGa.path);
        print("=============ImagePath0==========${imageGa.path}");
        imageCache.clear();
      } else {
        print('no image selected');
      }
    });
  }

  Future getCamaroImage() async {
    // var imaGe = await picker.getImage(source: ImageSource.camera);
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    print("==========ImagePath1=============${photo!.path}");
    setState(() {
      if (photo != null) {
        _image = File(
          photo.path,
        );
        print("===========ImagePath============${_image}");
        print("=============ImagePath==========${photo.path}");

        imageCache.clear();
      } else {
        print('no image selected');
      }
    });
  }

  Future<dynamic> uploadImageToFirebase(
      {required BuildContext contex, String? fileName, file}) async {
    try {
      var response = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putFile(file!);
      print("Response>>>>>>>>>>>>>>>>>>$response");

      return response.storage.ref('uploads/$fileName').getDownloadURL();
    } catch (e) {
      print(e);
    }
  }

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final textController = TextEditingController();
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

      if (authCredential.user != null) {
        if (textController.text.isNotEmpty || textController.text.isNotEmpty) {
          String url = await uploadImageToFirebase(
                  contex: context,
                  file: _image,
                  fileName: "${Random().nextInt(1234)}") ??
              "";

          DocumentReference doc = FirebaseFirestore.instance
              .collection("contact")
              .doc(FirebaseAuth.instance.currentUser!.uid);
          doc.set({
            "mobileNumber": phoneController.text,
            "name": textController.text,
            "message_status": "Online",
            "profile_picture": url,
          });
          var findDocId = doc.id;

          print("findDocId$findDocId");
          PreferencesManager.setUid("$findDocId");
          PreferencesManager.setProfilePicture(url);
          PreferencesManager.setName(textController.text);
          PreferencesManager.setMobileNumber(phoneController.text);

          print("CONTACT_PREFERENCE_SET_uid==>${PreferencesManager.getUid()}");
          print(
              "PREFERENCE_PROFILE_PICTURE==>${PreferencesManager.getProfilePicture()}");
          print("PREFERENCE_PROFILE_NAME==>${PreferencesManager.getName()}");
          print(
              "CONTACT_PREFERENCE_SET_MOBILE==>${PreferencesManager.getMobileNumber()}");

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomBarScreen(),
              ));
        } else {
          Get.showSnackbar(GetSnackBar(
            duration: Duration(seconds: 2),
            message: "Please Enter Your details",
          ));
        }
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
    return SingleChildScrollView(
      child: Container(
        height: 450.sp,
        child: Column(
          children: [
            Center(
              child: Text(
                "Trusted By Businesses Across India",
                style: TextStyle(
                    fontSize: 10.sp, color: Colors.grey.withOpacity(1.0)),
              ),
            ),
            CommonSizeBox.commonSize(height: 30.sp),
            Container(
              height: 100.sp,
              width: 100.sp,
              child: _image == null
                  ? Image.network(
                      "https://www.whatsappimages.in/wp-content/uploads/2021/12/girl-New-Superb-Whatsapp-Dp-Profile-Images-photo.jpg")
                  : Image.file(_image!),
            ),
            CommonSizeBox.commonSize(height: 5.sp),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Container(
                                    child: MaterialButton(
                                      child: Text(
                                        'gallery',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                        getGalleryImage();
                                      },
                                    ),
                                    width: 220,
                                    height: 60,
                                    color: ColorPicker.grey,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: MaterialButton(
                                      child: Text(
                                        'camera',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      // color: Colors.deepOrange,
                                      onPressed: () {
                                        Get.back();
                                        getCamaroImage();
                                      },
                                    ),
                                    width: 220,
                                    height: 60,
                                    color: ColorPicker.grey,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ));
              },
              child: Container(
                height: 30.sp,
                width: 100.sp,
                color: ColorPicker.lightContainerColor,
                child: Center(
                    child: CommonText.simpleText(
                        text: "Choice Profile",
                        color: ColorPicker.grey,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            CommonSizeBox.commonSize(height: 40.sp),
            CommonTextFiled.commonTextFiled(
                inputFormatters: [LengthLimitingTextInputFormatter(13)],
                onChange: (value) {},
                textInputType: TextInputType.name,
                hintText: "Enter your name",
                controller: textController),
            CommonSizeBox.commonSize(height: 10.sp),
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
                      currentState =
                          MobileVerificationState.SHOW_OTP_FORM_STATE;
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
                child: CommonButton.commonButton123(
                    text: "GET OTP", color: ColorPicker.grey),
              ),
              // color: Colors.blue,
              // textColor: Colors.white,
            )
          ],
        ),
      ),
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
      resizeToAvoidBottomInset: true,
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
