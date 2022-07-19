import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/button.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:sizer/sizer.dart';
import '../../common/app_bar.dart';
import 'customer_data_screen.dart';

class DeleteAndShareScreen extends StatefulWidget {
  final mobileNumberDocId;
  final uid;

  const DeleteAndShareScreen({super.key, this.mobileNumberDocId, this.uid});

  @override
  State<DeleteAndShareScreen> createState() => _DeleteAndShareScreenState();
}

class _DeleteAndShareScreenState extends State<DeleteAndShareScreen> {
  Future shareFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return null;

    await FlutterShare.shareFile(
      title: 'Example share',
      text: 'Example share text',
      filePath: result.files[0] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("DeleteAndShareScreen_uId${widget.uid}");
    return Scaffold(
        appBar: CommonAppBar.appBarCenterNameAndBackArrow(
            text: "Delete & Share", color: ColorPicker.grey),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Column(children: [
              SvgPicture.asset("assets/svg/ic_baseline-folder-delete.svg",
                  color: ColorPicker.lightContainerColor, height: 150.sp),
              InkWell(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection("contact")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("mobile_number")
                      .doc(widget.uid)
                      .collection("user_data")
                      .doc(widget.mobileNumberDocId)
                      .delete()
                      .then((value) => Get.back());
                  Get.back();
                },
                child: CommonButton.commonButton(text: "Delete"),
              ),
              Spacer(),
              SvgPicture.asset("assets/svg/ic_baseline-screen-share.svg",
                  color: ColorPicker.lightContainerColor, height: 150.sp),
              InkWell(
                onTap: () {
                  shareFile();
                },
                child: CommonButton.commonButton(text: "Share"),
              ),
              CommonSizeBox.commonSize(height: 150.sp)
            ]),
          ),
        ));
  }
}
