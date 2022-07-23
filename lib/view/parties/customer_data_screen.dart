import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safe_khata_book/common/button.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:safe_khata_book/view/parties/edit_entry_screen.dart';
import 'package:safe_khata_book/view/parties/up_date_details_screen.dart';
import 'package:safe_khata_book/view/whatssp/message_room.dart';
import 'package:sizer/sizer.dart';

import '../../c_widget/widget.dart';
import '../../common/common_sizebox.dart';

class CustomerData extends StatefulWidget {
  final name;
  final uid;
  final totalAmount;
  final roomId;

  const CustomerData({
    super.key,
    required this.name,
    this.uid,
    this.totalAmount,
    this.roomId,
  });

  @override
  State<CustomerData> createState() => _CustomerDataState();
}

class _CustomerDataState extends State<CustomerData> {
  num finalSum = 0;
  num finalRemove = 0;
  @override

  /// Date format
  final f = new DateFormat('dd-MM-yyyy hh:mm');

  @override
  Widget build(BuildContext context) {
    PreferencesManager.setName(widget.name);
    print("14525412541${widget.uid}");
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("contact")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("mobile_number")
          .doc(widget.uid)
          .collection("user_data")
          .orderBy("date_time", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          print("CustomerData_uId${widget.uid}");
          final data = snapshot.data!.docs;

          print("data_length in doc==>>${data.length}");

          print("showListData${data}");

          /// index vise index
          finalSum = 0;
          finalRemove = 0;
          for (var i = 0; i < data.length; i++) {
            if (data[i]["check_value"] == true) {
              finalSum += num.parse(data[i]["gave_&_got_amount"]);
            } else {
              finalRemove += num.parse(data[i]["gave_&_got_amount"]);
            }
          }
          var dataSave = "${finalSum - finalRemove}";

          print("finalsum$finalSum");
          print("finalRemove$finalRemove");

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

                        Get.to(EditEntryScreen(
                          uId: widget.uid,
                          bool: false,
                        ));
                      },
                      child: CommonButton.commonYouGaveButton(
                          text: "YOU GAVE \$", color: Colors.red),
                    ),
                    InkWell(
                      onTap: () async {
                        await PreferencesManager.setYouGave("youGot");
                        Get.to(EditEntryScreen(
                          uId: widget.uid,
                          bool: true,
                        ));
                      },
                      child: CommonButton.commonYouGaveButton(
                          text: "YOU GOT \$", color: ColorPicker.green),
                    )
                  ]),
            ),
            appBar: PreferredSize(
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.11,
                  color: ColorPicker.grey,
                  // color: ColorPicker.lightContainerColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 25, right: 15),
                    child: Row(children: [
                      InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("contact")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("mobile_number")
                              .doc(widget.uid)
                              .update({
                            "check_value":
                                finalSum > finalRemove ? true : false,
                            // "date_time": "${f.format(DateTime.now())}",
                            "gave_&_got_amount":
                                dataSave != "" ? dataSave : '0',
                          });

                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      CommonSizeBox.commonSize(width: 10.sp),
                      Container(
                        height: 35.sp,
                        width: 35.sp,
                        decoration: BoxDecoration(
                            color: Colors.yellow, shape: BoxShape.circle),
                      ),
                      CommonSizeBox.commonSize(width: 10.sp),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 8),
                        child: CommonText.simpleText(
                            text: widget.name,
                            fontSize: 15.sp,
                            color: ColorPicker.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          ///send to chatRoomId

                          Get.to(MessageRoomScreen(
                            chatRoomId: widget.roomId,
                            name: widget.name,
                          ));
                        },
                        child: Icon(
                          Icons.whatsapp,
                          color: ColorPicker.whiteColor,
                          size: 25.sp,
                        ),
                      ),
                      CommonSizeBox.commonSize(width: 10.sp),
                      Icon(
                        Icons.more_vert,
                        color: ColorPicker.whiteColor,
                      ),
                    ]),
                  ),
                ),
                preferredSize: Size.fromHeight(80.sp)),
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
                                text: finalSum > finalRemove
                                    ? 'You will got'
                                    : "You will gave",
                                color: ColorPicker.grey,
                                fontSize: 13.sp),
                            CommonText.simpleText(
                                text: '\$ ${finalSum - finalRemove}',
                                color: finalSum > finalRemove
                                    ? ColorPicker.green
                                    : ColorPicker.red,
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
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    ///All user_data Get ID
                    final userDataId = data[index].id;
                    PreferencesManager.setUserData_Uid(userDataId);

                    // removeAdd.insert(index, {
                    //   "amount": num.parse(data[index]["gave_&_got_amount"]),
                    //   "check_value": data[index]["check_value"]
                    // });

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(UpDateDetailsScreen(
                            userDataId: userDataId,
                            uid: widget.uid,
                          ));
                        },
                        child: Container(
                          // color: ColorPicker.red,
                          color: ColorPicker.lightContainerColor,
                          height: 75.sp,
                          width: Get.width,

                          child: Row(children: [
                            Container(
                              width: 80.sp,
                              // color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonSizeBox.commonSize(height: 4.sp),
                                    showListText(
                                        text:
                                            "${f.format(DateTime.parse(data[index]["date_time"]))}",
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
                                                text:
                                                    "Bal \$${data[index]["gave_&_got_amount"]} ",
                                                fontSize: 8.sp,
                                                color: Colors.black
                                                    .withOpacity(0.4))),
                                      ),
                                    ),
                                    CommonSizeBox.commonSize(height: 5.sp),
                                    Container(
                                      height: 23.sp,
                                      width: 70.sp,
                                      // color: ColorPicker.green,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: showListText(
                                            maxline: 2,
                                            text: data[index]["details"] != null
                                                ? "${data[index]["details"]} "
                                                : "no details",
                                            fontSize: 8.sp,
                                            color:
                                                Colors.black.withOpacity(0.4)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                height: Get.height,
                                width: 30.sp,
                                // color: Colors.red,
                                child: Column(
                                  children: [
                                    Spacer(),
                                    Container(
                                        height: 50.sp,
                                        width: 30.sp,

                                        // color: Colors.blue,
                                        child:
                                            // data[index]["image_url"] != null
                                            //     ?
                                            Image.network(
                                          "${data[index]["image_url"]}",
                                          fit: BoxFit.contain,
                                          errorBuilder: (contex, ex, st) {
                                            return SizedBox();
                                          },
                                        )
                                        // : SizedBox()
                                        ),
                                    CommonSizeBox.commonSize(height: 14.0)
                                  ],
                                )),
                            Container(
                              height: Get.height,
                              child: Center(
                                  child: showListText(
                                      text: data[index]["check_value"] == false
                                          ? "${data[index]["gave_&_got_amount"]}"
                                          : "",
                                      color: ColorPicker.red,
                                      fontSize: 14.sp)),
                              width: 85.sp,
                              color: ColorPicker.lightContainerColor,
                            ),
                            Expanded(
                              child: Container(
                                height: Get.height,
                                child: Center(
                                    child: showListText(
                                        text: data[index]["check_value"] == true
                                            ? "${data[index]["gave_&_got_amount"]}"
                                            : "",
                                        color: ColorPicker.green,
                                        fontSize: 14.sp)),
                                color: Colors.transparent,
                              ),
                            ),
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
