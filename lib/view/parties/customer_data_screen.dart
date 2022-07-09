import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/button.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:safe_khata_book/view/parties/edit_entry_screen.dart';
import 'package:safe_khata_book/view/parties/entry_details_screen.dart';
import 'package:sizer/sizer.dart';

import '../../common/common_sizebox.dart';

class CustomerData extends StatefulWidget {
  final name;

  const CustomerData({super.key, required this.name});

  @override
  State<CustomerData> createState() => _CustomerDataState();
}

class _CustomerDataState extends State<CustomerData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection("mobile_number").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!.docs;

          return Scaffold(
            bottomNavigationBar: Container(
              height: 60.sp,
              color: ColorPicker.lightContainerColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        await PreferencesManager.setYouGave("youGave");
                        Get.to(EditEntryScreen());
                      },
                      child: CommonButton.commonYouGaveButton(
                          text: "YOU GAVE \$", color: Colors.red),
                    ),
                    InkWell(
                      onTap: () async {
                        await PreferencesManager.setYouGave("youGot");
                        Get.to(EditEntryScreen());
                      },
                      child: CommonButton.commonYouGaveButton(
                          text: "YOU GOT \$", color: ColorPicker.green),
                    )
                  ]),
            ),
            appBar: CommonAppBar.customerAppData(
              name: "${widget.name}",
              subName: "subName",
              icon: Icon(
                Icons.more_vert,
                color: ColorPicker.whiteColor,
              ),
              container: Container(
                height: 35.sp,
                width: 35.sp,
                decoration:
                    BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
              ),
            ),
            body: Column(children: [
              Container(
                height: 50.sp,
                width: Get.width,
                color: ColorPicker.lightContainerColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                    top: 5,
                    bottom: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorPicker.whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText.simpleText(
                                text: 'You will give',
                                color: ColorPicker.grey,
                                fontSize: 13.sp),
                            CommonText.simpleText(
                                text: '\$ 10000000',
                                color: ColorPicker.green,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500)
                          ]),
                    ),
                  ),
                ),
              ),
              Container(
                height: 55.sp,
                color: ColorPicker.blackSad,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, top: 9, bottom: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 22.sp,
                                  width: 22.sp,
                                  child: SvgPicture.asset(
                                      "assets/svg/pdf-svgrepo-com.svg")),
                              CommonSizeBox.commonSize(height: 5.0),
                              CommonText.simpleText(
                                  text: "Report",
                                  fontSize: 10.sp,
                                  color: Colors.black)
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 22.sp,
                                width: 22.sp,
                                child: SvgPicture.asset(
                                    "assets/svg/currency_rupee_FILL0_wght400_GRAD0_opsz48.svg")),
                            CommonSizeBox.commonSize(height: 5.0),
                            CommonText.simpleText(
                                text: "Payment",
                                fontSize: 10.sp,
                                color: Colors.black)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 22.sp,
                                width: 22.sp,
                                child: Icon(Icons.whatsapp)),
                            CommonSizeBox.commonSize(height: 5.0),
                            CommonText.simpleText(
                                text: "Payment",
                                fontSize: 10.sp,
                                color: Colors.black)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 22.sp,
                                width: 22.sp,
                                child: Icon(Icons.message)),
                            CommonSizeBox.commonSize(height: 5.0),
                            CommonText.simpleText(
                                text: "Payment",
                                fontSize: 10.sp,
                                color: Colors.black)
                          ],
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, top: 10, right: 15, bottom: 5),
                child: Row(
                  children: [
                    CommonText.simpleText(
                        text: "ENTRIES",
                        fontWeight: FontWeight.w500,
                        fontSize: 9.sp,
                        color: ColorPicker.grey),
                    CommonSizeBox.commonSize(width: 100.sp),
                    CommonText.simpleText(
                        text: "YOU GAVE",
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorPicker.grey),
                    CommonSizeBox.commonSize(width: 38.sp),
                    CommonText.simpleText(
                        text: "YOU GOTE",
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorPicker.grey),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(EntryDetailsScreen(
                            name: widget.name,
                          ));
                        },
                        child: Container(
                          color: ColorPicker.lightContainerColor,
                          height: 75.sp,
                          width: Get.width,
                          child: Row(children: [
                            Container(
                              width: 125.sp,
                              // color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonSizeBox.commonSize(height: 4.sp),
                                    showListText(
                                        text: "${DateTime.now()}",
                                        color: Colors.black.withOpacity(0.4),
                                        fontSize: 8.sp),
                                    CommonSizeBox.commonSize(height: 5.sp),
                                    Container(
                                      height: 15.sp,
                                      width: 70.sp,
                                      color: ColorPicker.lightContainerColor,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Center(
                                            child: showListText(
                                                text: "Bal \$ 10000 ",
                                                fontSize: 8.sp,
                                                color: Colors.black
                                                    .withOpacity(0.4))),
                                      ),
                                    ),
                                    CommonSizeBox.commonSize(height: 5.sp),
                                    showListText(
                                        text: "2 hours ago",
                                        color: Colors.black.withOpacity(0.6)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: Get.height,
                              child: Center(
                                  child: showListText(
                                      text: "\$ 100",
                                      color: ColorPicker.red,
                                      fontSize: 14.sp)),
                              width: 85.sp,
                              color: ColorPicker.lightContainerColor,
                            ),
                            showListText(
                                text: "\$ 10000000",
                                color: ColorPicker.green,
                                fontSize: 14.sp)
                          ]),
                        ),
                      ),
                    );
                  },
                ),
              )
            ]),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  showListText({@required String? text, Color? color, fontSize, fontWeight}) {
    return Text(
      "${text ?? 0}",
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
