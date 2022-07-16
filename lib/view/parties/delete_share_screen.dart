import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/button.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/view/parties/parties_screen.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_bar.dart';

class DeleteAndShareScreen extends StatefulWidget {
  final mobileNumberDocId;
  final userDataDocId;

  const DeleteAndShareScreen(
      {super.key, this.mobileNumberDocId, this.userDataDocId});

  @override
  State<DeleteAndShareScreen> createState() => _DeleteAndShareScreenState();
}

class _DeleteAndShareScreenState extends State<DeleteAndShareScreen> {
  @override
  Widget build(BuildContext context) {
    print("mobileNumberDocId${widget.mobileNumberDocId}");
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
                      .collection("mobile_number")
                      // .doc("1uic3F3Usr4Jylnwm9C3")
                      .doc(widget.mobileNumberDocId)
                      .delete()
                      .then((value) => Get.to(PartiesScreen()));
                },
                child: CommonButton.commonButton(text: "Delete"),
              ),
              Spacer(),
              SvgPicture.asset("assets/svg/ic_baseline-screen-share.svg",
                  color: ColorPicker.lightContainerColor, height: 150.sp),
              InkWell(
                onTap: () {},
                child: CommonButton.commonButton(text: "Share"),
              ),
              CommonSizeBox.commonSize(height: 150.sp)
            ]),
          ),
        ));
  }
}
