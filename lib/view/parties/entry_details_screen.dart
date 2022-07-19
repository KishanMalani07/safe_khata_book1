import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:safe_khata_book/view/parties/up_date_details_screen.dart';
import 'package:safe_khata_book/view_model/save_data_entry.dart';
import 'package:sizer/sizer.dart';

import '../../common/button.dart';

class EntryDetailsScreen extends StatefulWidget {
  final name;
  final details;

  const EntryDetailsScreen({super.key, required this.name, this.details});

  @override
  State<EntryDetailsScreen> createState() => _EntryDetailsScreenState();
}

class _EntryDetailsScreenState extends State<EntryDetailsScreen> {
  ///get data in controller
  SaveDataEntryController showData = Get.find();

  /// Date format
  final f = new DateFormat('dd-MM-yyyy hh:mm');

  @override
  Widget build(BuildContext context) {
    print(
        "EntryDetailsScreen_Preference_set_uId${PreferencesManager.getUid()}");

    return GetBuilder<SaveDataEntryController>(
      builder: (controller) {
        return Scaffold(
            bottomNavigationBar: Container(
              height: 50.sp,
              color: ColorPicker.lightContainerColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("contact")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("mobile_number")
                  .doc(PreferencesManager.getUid())
                  .collection("user_data")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                var getData = snapshot.data!.docs;

                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 200.sp,
                      color: ColorPicker.lightContainerColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(children: [
                                Container(
                                  height: 35.sp,
                                  width: 35.sp,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                ),
                                CommonSizeBox.commonSize(width: 10.sp),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CommonText.simpleText(
                                      text: "${widget.name}",
                                      fontSize: 15.sp,
                                      color: Colors.grey,
                                    ),
                                    CommonText.simpleText(
                                        text: "${f.format(DateTime.now())}",
                                        fontSize: 7.sp,
                                        color: ColorPicker.grey)
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonText.simpleText(
                                        text: "\$ 1000",
                                        fontSize: 15.sp,
                                        color: showData.saveStatusCheck == false
                                            ? ColorPicker.red
                                            : ColorPicker.green,
                                        fontWeight: FontWeight.w500),
                                    CommonText.simpleText(
                                        text: showData.saveStatusCheck == false
                                            ? "You gave"
                                            : "You got",
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
                                    text: "${widget.details ?? ""}",
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
                              padding:
                                  const EdgeInsets.only(top: 12.0, bottom: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText.simpleText(
                                      text: "Running Balance",
                                      fontSize: 11.sp,
                                      color: Colors.grey,
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w500),
                                  CommonText.simpleText(
                                      text: "\$${controller.saveAmount}",
                                      fontSize: 15.sp,
                                      color: controller.saveStatusCheck == false
                                          ? ColorPicker.red
                                          : ColorPicker.green,
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
                                Get.to(UpDateDetailsScreen(
                                  uid: PreferencesManager.getUid(),
                                ));
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
                ]);
              },
            ));
      },
    );
  }
}
