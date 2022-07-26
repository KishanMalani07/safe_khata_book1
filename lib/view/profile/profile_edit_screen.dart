import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/custom_textField.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:sizer/sizer.dart';

import '../../common/button.dart';
import '../../common/color.dart';
import '../../common/common_sizebox.dart';
import '../../common/text.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final phoneController = TextEditingController();
  final textController = TextEditingController();
  final otpController = TextEditingController();

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

  @override
  void initState() {
    textController.text = PreferencesManager.getName();
    phoneController.text = PreferencesManager.getMobileNumber();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar.appBarCenterNameAndBackArrow(
          text: "Edit Profile", color: ColorPicker.grey),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            height: 700.sp,
            child: Column(children: [
              CommonSizeBox.commonSize(height: 30.sp),
              PreferencesManager.getProfilePicture() == null
                  ? Container(
                      height: 100.sp,
                      width: 100.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.network(
                        "https://www.whatsappimages.in/wp-content/uploads/2021/12/girl-New-Superb-Whatsapp-Dp-Profile-Images-photo.jpg",
                        fit: BoxFit.contain,
                      ))
                  : Container(
                      height: 100.sp,
                      width: 100.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.network(
                        "${PreferencesManager.getProfilePicture()}",
                        fit: BoxFit.contain,
                      )),
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
                                              color: Colors.white,
                                              fontSize: 20),
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
                                              color: Colors.white,
                                              fontSize: 20),
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
              CommonSizeBox.commonSize(height: 120.sp),
              Padding(
                  padding: EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: InkWell(
                    onTap: () async {
                      String url = await uploadImageToFirebase(
                              contex: context,
                              file: _image,
                              fileName: "${Random().nextInt(1234)}") ??
                          "";
                      FirebaseFirestore.instance
                          .collection("contact")
                          .doc(PreferencesManager.getUid())
                          .update({
                        "mobileNumber": phoneController.text,
                        "name": textController.text,
                        "profile_picture": url,
                      }).then((value) {
                        PreferencesManager.setMobileNumber(
                            phoneController.text);
                        PreferencesManager.setName(textController.text);
                        PreferencesManager.setProfilePicture(url);

                        print(
                            "new_set_Preference_setMobileNumber${PreferencesManager.getMobileNumber()}");
                        print(
                            "new_set_Preference_setName${PreferencesManager.getName()}");
                        print(
                            "new_set_Preference_setProfilePicture${PreferencesManager.getProfilePicture()}");
                      }).then((value) => Get.back());
                    },
                    child: CommonButton.commonButton123(
                        text: "Update Profile", color: ColorPicker.grey),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
