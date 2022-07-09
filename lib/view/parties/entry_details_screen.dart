import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:safe_khata_book/view/parties/edit_entry_screen.dart';
import 'package:sizer/sizer.dart';

import '../../common/button.dart';

class EntryDetailsScreen extends StatefulWidget {
  final name;

  const EntryDetailsScreen({super.key, required this.name});

  @override
  State<EntryDetailsScreen> createState() => _EntryDetailsScreenState();
}

class _EntryDetailsScreenState extends State<EntryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50.sp,
        color: ColorPicker.lightContainerColor,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          CommonButton.commonYouGaveButton(
              text: "YOU GAVE \$", color: Colors.red),
          CommonButton.commonWithIconButton(
              text: " SHARE",
              color: ColorPicker.blue.withOpacity(1),
              icon: Icon(
                Icons.share,
                color: ColorPicker.whiteColor,
              ))
        ]),
      ),
      appBar: CommonAppBar.appBarCenterNameAndBackArrow(
        text: "Entry Details",
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 200.sp,
            color: ColorPicker.lightContainerColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: Row(children: [
                      Container(
                        height: 35.sp,
                        width: 35.sp,
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                      CommonSizeBox.commonSize(width: 10.sp),
                      Column(
                        children: [
                          CommonText.simpleText(
                            text: "${widget.name}",
                            fontSize: 15.sp,
                            color: Colors.grey,
                          ),
                          CommonText.simpleText(
                              text: "${DateTime.now()}",
                              fontSize: 7.sp,
                              color: ColorPicker.grey)
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText.simpleText(
                              text: "\$ 4000",
                              fontSize: 15.sp,
                              color: ColorPicker.green,
                              fontWeight: FontWeight.w500),
                          CommonText.simpleText(
                              text: "You got",
                              fontSize: 10.sp,
                              color: ColorPicker.grey)
                        ],
                      ),
                    ]),
                  ),
                  Divider(
                    color: ColorPicker.lightContainerColor,
                    thickness: 1.5,
                  ),

                  ///======Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.simpleText(
                          text: "Details",
                          fontSize: 11.sp,
                          color: Colors.grey,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500),
                      CommonSizeBox.commonSize(height: 5.sp),
                      CommonText.simpleText(
                          text: "Show details",
                          fontSize: 10.sp,
                          color: ColorPicker.black)
                    ],
                  ),
                  CommonSizeBox.commonSize(height: 5.sp),
                  Divider(
                    color: ColorPicker.lightContainerColor,
                    thickness: 1.5,
                  ),

                  ///======Running Balance
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText.simpleText(
                            text: "Running Balance",
                            fontSize: 11.sp,
                            color: Colors.grey,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w500),
                        CommonText.simpleText(
                            text: "\$ 21000",
                            fontSize: 15.sp,
                            color: Colors.red,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ),

                  Divider(
                    color: ColorPicker.lightContainerColor,
                    thickness: 1.5,
                  ),
                  CommonSizeBox.commonSize(height: 10.sp),
                  InkWell(
                    onTap: () {
                      Get.to(EditEntryScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit),
                        CommonSizeBox.commonSize(width: 3.sp),
                        CommonText.simpleText(
                            text: "EDIT ENTRY",
                            fontSize: 12.sp,
                            color: ColorPicker.black,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
