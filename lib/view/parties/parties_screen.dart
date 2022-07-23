import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/custom_textField.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:safe_khata_book/view/parties/customer_data_screen.dart';
import 'package:safe_khata_book/view/parties/view_report_screen.dart';
import 'package:sizer/sizer.dart';
import '../../c_widget/widget.dart';
import '../../view_model/save_data_entry.dart';

class PartiesScreen extends StatefulWidget {
  const PartiesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PartiesScreen> createState() => _PartiesScreenState();
}

class _PartiesScreenState extends State<PartiesScreen> {
  @override
  var number;

  ///===============CHAT_ROOM_ID=================>>>
  // String chatRoomId({String? user1, String? user2}) {
  //   if (user1![0].toLowerCase().codeUnits[0] >
  //       user2![0].toLowerCase().codeUnits[0]) {
  //     return "$user1$user2";
  //   } else {
  //     return "$user2$user1";
  //   }
  // }
  Future<String> chatRoomId(String user1, String user2) async {
    if (user1[0].toLowerCase().codeUnitAt(0) >
        user2.toLowerCase().codeUnitAt(0)) {
      return '$user1$user2';
    } else {
      return '$user2$user1';
    }
  }

  /// Date format
  final f = new DateFormat('dd-MM-yyyy hh:mm');
  TextEditingController searchController = TextEditingController();
  String searchText = "";

  ///calculation
  num finalSum1 = 0;
  num finalRemove1 = 0;

  SaveDataEntryController showData = Get.find();

  int? length;

  @override
  Widget build(BuildContext context) {
    print("CURRENT_USER_SET_uid${PreferencesManager.getUid()}");
    return Scaffold(
        floatingActionButton: InkWell(
          onTap: () async {
            final FullContact contact =
                await FlutterContactPicker.pickFullContact();
            print("contact123${contact}");

            Map<String, dynamic> getContact = {
              "firstName": "${contact.name!.firstName}",
              "number": "${contact.phones[0].number}",
              "profile_picture": "${contact.photo}",
              "check_value": true,
              "date_time": "${f.format(DateTime.now())}",
              "gave_&_got_amount": 0,
              "message_status": "Online"
            };
            print("getContact-----------------$getContact");

            FirebaseFirestore.instance
                .collection("contact")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("mobile_number")
                .add(getContact);
          },
          child: Container(
            height: 50.sp,
            width: 50.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.5),
            ),
            child: Center(
                child: Icon(
              Icons.person_add_alt_1_rounded,
              color: Colors.black.withOpacity(1),
            )),
          ),
        ),
        appBar: CommonAppBar.appBarCenterName(name: "Customers"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Container(
                height: 80.sp,
                width: Get.width,
                color: ColorPicker.lightContainerColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 20),
                      child: Column(
                        children: [
                          willGiveText(
                            text:
                                // "\$ ${showAllData[0]["gave_&_got_amount"]}",
                                "\$ 2000000",
                            color: Colors.green,
                          ),
                          Text(
                            "You will gote",
                            style: TextStyle(
                                color: ColorPicker.grey,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: ColorPicker.grey.withOpacity(0.5),
                      width: 2,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 20),
                      child: Column(
                        children: [
                          willGiveText(
                              text: "\$ 2000000",
                              // "\$ ${showAllData[0]["gave_&_got_amount"]}",
                              color: Colors.red),
                          Text(
                            "You will gave",
                            style: TextStyle(
                                color: ColorPicker.grey,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Container(
                  height: 30.sp,
                  width: Get.width,
                  color: ColorPicker.lightContainerColor,
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      Get.to(ViewReportScreen());
                    },
                    child: viewReportText(
                        text: ("View Report"),
                        color: ColorPicker.black,
                        fontSize: 15.sp),
                  ))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                      width: 180.sp,
                      child: CommonTextFiled.otpTextFiled(
                          controller: searchController,
                          onChange: (value) {
                            setState(() {
                              searchText = value;
                            });
                          },
                          hintText: "Search",
                          suffixIcon: Icon(Icons.clear),
                          prefix: SizedBox(width: 15),
                          inputFormatters: [],
                          textInputType: TextInputType.text)),
                ),
                InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/svg/filter-svgrepo-com.svg",
                    height: 30.sp,
                    width: 30.sp,
                    color: ColorPicker.grey,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/svg/pdf-svgrepo-com.svg",
                    height: 30.sp,
                    width: 30.sp,
                    color: ColorPicker.grey,
                  ),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: searchController.text.isEmpty
                  ? FirebaseFirestore.instance
                      .collection("contact")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("mobile_number")
                      .orderBy("date_time", descending: true)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection("contact")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("mobile_number")
                      .where('firstName',
                          isGreaterThanOrEqualTo: searchController.text)
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                print("1111222333_GET_MOBILE_UID");

                if (snapshot.hasData) {
                  /// DECALARE THIS SNAPSHOT.HASHDATA AFTER
                  var doc = snapshot.data!.docs;
                  print("length======>${doc.length}");
                  print("Text======>${searchText}");

                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: doc.length,
                      itemBuilder: (context, index) {
                        ///GetData
                        final getData1 = doc[index].id;
                        PreferencesManager.set_Get_Mobile_Uid(getData1);

                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () async {
                              String? roomId = await chatRoomId(
                                  "${FirebaseAuth.instance.currentUser!.uid}",
                                  "${doc[index]["firstName"]}");
                              print('ROOMID$roomId');
                              Get.to(() => CustomerData(
                                    roomId: roomId,
                                    uid: getData1,
                                    name: "${doc[index]["firstName"]}",
                                  ));
                            },
                            child: Dismissible(
                              direction: DismissDirection.startToEnd,
                              background: Container(
                                padding: EdgeInsets.symmetric(horizontal: 28),
                                color: ColorPicker.red,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: ColorPicker.whiteColor,
                                    ),
                                  ],
                                ),
                              ),
                              onDismissed: (direction) {
                                FirebaseFirestore.instance
                                    .collection("contact")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("mobile_number")
                                    .doc(doc[index].id)
                                    .delete()
                                    .then((value) =>
                                        Get.showSnackbar(GetSnackBar(
                                          duration: Duration(seconds: 2),
                                          message: "successfully user delete",
                                        )));
                              },
                              key: ValueKey("${doc[index]["firstName"]}"),
                              child: Container(
                                color: ColorPicker.lightContainerColor,
                                height: 65.sp,
                                width: Get.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 50.sp,
                                          width: 50.sp,
                                          decoration: BoxDecoration(
                                            color: ColorPicker.grey,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        CommonSizeBox.commonSize(width: 20.sp),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 17, bottom: 17),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 15.sp,
                                                width: 80.sp,
                                                // color: Colors.red,
                                                child: showListText(
                                                    text:
                                                        "${doc[index]["firstName"]}",
                                                    fontSize: 15.sp,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxline: 1,
                                                    color: Colors.black),
                                              ),
                                              Spacer(),
                                              showListText(
                                                  text:
                                                      "${doc[index]["date_time"]}",
                                                  color: Colors.black
                                                      .withOpacity(0.5))
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 17, bottom: 17),
                                          child: Column(
                                            children: [
                                              showListText(
                                                  text:
                                                      "${doc[index]["gave_&_got_amount"]}",
                                                  fontSize: 15.sp,
                                                  color: doc[index]
                                                              ["check_value"] ==
                                                          true
                                                      ? Colors.green
                                                      : Colors.red),
                                              Spacer(),
                                              showListText(
                                                  text: doc[index]
                                                              ["check_value"] ==
                                                          false
                                                      ? "You will got"
                                                      : "You will gave",
                                                  color: doc[index]
                                                              ["check_value"] ==
                                                          false
                                                      ? ColorPicker.red
                                                      : ColorPicker.green),
                                            ],
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    // child: Text("No Data Found"),
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ));
  }

  willGiveText({@required String? text, Color? color}) {
    return Text(
      text!,
      style:
          TextStyle(fontSize: 22.sp, color: color, fontWeight: FontWeight.w900),
    );
  }

  viewReportText({@required String? text, Color? color, fontSize}) {
    return Text(
      '${text ?? 0}',
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttercontactpicker/fluttercontactpicker.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:safe_khata_book/common/app_bar.dart';
// import 'package:safe_khata_book/common/color.dart';
// import 'package:safe_khata_book/common/common_sizebox.dart';
// import 'package:safe_khata_book/common/custom_textField.dart';
// import 'package:safe_khata_book/common/preferences_manager.dart';
// import 'package:safe_khata_book/view/parties/customer_data_screen.dart';
// import 'package:safe_khata_book/view/parties/view_report_screen.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../c_widget/widget.dart';
// import '../../view_model/save_data_entry.dart';
//
// class PartiesScreen extends StatefulWidget {
//   const PartiesScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<PartiesScreen> createState() => _PartiesScreenState();
// }
//
// class _PartiesScreenState extends State<PartiesScreen> {
//   @override
//   var number;
//   getData() async {
//     var data = await FirebaseFirestore.instance
//         .collection("contact")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();
//
//     Map<String, dynamic>? info = data.data();
//
//     setState(() {
//       number = info!["mobileNumber"];
//       print("mobileNumber_mobileNumber$number");
//     });
//   }
//
//   /// Date format
//   final f = new DateFormat('dd-MM-yyyy hh:mm');
//   TextEditingController searchController = TextEditingController();
//   String searchText = "";
//
//   ///calculation
//   num finalSum1 = 0;
//   num finalRemove1 = 0;
//
//   SaveDataEntryController showData = Get.find();
//
//   int? length;
//
//   @override
//   void initState() {
//     getData();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: InkWell(
//           onTap: () async {
//             final FullContact contact =
//                 await FlutterContactPicker.pickFullContact();
//             print("contact123${contact}");
//             var w = "${contact.phones[0].number}"
//                 .split('-')[0]
//                 .split(' ')[0]
//                 .split('(')[1]
//                 .split(')')[0];
//             var x = "${contact.phones[0].number}".split('-')[0].split(' ')[1];
//             var y = "${contact.phones[0].number}".split('-')[1];
//             var z = '+91$w$x$y';
//
//             print('+91$z');
//
//             Map<String, dynamic> getContact = {
//               "firstName": "${contact.name!.firstName}",
//               "number": z,
//               "profile_picture": "${contact.photo}",
//               "check_value": true,
//               "date_time": "${f.format(DateTime.now())}",
//               "gave_&_got_amount": 0,
//             };
//             print("getContact-----------------$getContact");
//
//             z == number
//                 ? FirebaseFirestore.instance
//                     .collection("contact")
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .collection("mobile_number")
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .set(getContact)
//                 : FirebaseFirestore.instance
//                     .collection("contact")
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .collection("mobile_number")
//                     .add(getContact);
//           },
//           child: Container(
//             height: 50.sp,
//             width: 50.sp,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.grey.withOpacity(0.5),
//             ),
//             child: Center(
//                 child: Icon(
//               Icons.person_add_alt_1_rounded,
//               color: Colors.black.withOpacity(1),
//             )),
//           ),
//         ),
//         appBar: CommonAppBar.appBarCenterName(name: "Customers"),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 10,
//                 right: 10,
//               ),
//               child: Container(
//                 height: 80.sp,
//                 width: Get.width,
//                 color: ColorPicker.lightContainerColor,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 12, top: 20),
//                       child: Column(
//                         children: [
//                           willGiveText(
//                             text:
//                                 // "\$ ${showAllData[0]["gave_&_got_amount"]}",
//                                 "\$ 2000000",
//                             color: Colors.green,
//                           ),
//                           Text(
//                             "You will gote",
//                             style: TextStyle(
//                                 color: ColorPicker.grey,
//                                 fontSize: 11.sp,
//                                 fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                     ),
//                     VerticalDivider(
//                       color: ColorPicker.grey.withOpacity(0.5),
//                       width: 2,
//                       thickness: 2,
//                       indent: 20,
//                       endIndent: 20,
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(left: 12, right: 12, top: 20),
//                       child: Column(
//                         children: [
//                           willGiveText(
//                               text: "\$ 2000000",
//                               // "\$ ${showAllData[0]["gave_&_got_amount"]}",
//                               color: Colors.red),
//                           Text(
//                             "You will gave",
//                             style: TextStyle(
//                                 color: ColorPicker.grey,
//                                 fontSize: 11.sp,
//                                 fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
//               child: Container(
//                   height: 30.sp,
//                   width: Get.width,
//                   color: ColorPicker.lightContainerColor,
//                   child: Center(
//                       child: InkWell(
//                     onTap: () {
//                       Get.to(ViewReportScreen());
//                     },
//                     child: viewReportText(
//                         text: ("View Report"),
//                         color: ColorPicker.grey,
//                         fontSize: 15.sp),
//                   ))),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                   child: SizedBox(
//                       width: 180.sp,
//                       child: CommonTextFiled.otpTextFiled(
//                           controller: searchController,
//                           onChange: (value) {
//                             setState(() {
//                               searchText = value;
//                             });
//                           },
//                           hintText: "Search",
//                           suffixIcon: Icon(Icons.clear),
//                           prefix: SizedBox(width: 15),
//                           inputFormatters: [],
//                           textInputType: TextInputType.text)),
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: SvgPicture.asset(
//                     "assets/svg/filter-svgrepo-com.svg",
//                     height: 30.sp,
//                     width: 30.sp,
//                     color: ColorPicker.grey,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: SvgPicture.asset(
//                     "assets/svg/pdf-svgrepo-com.svg",
//                     height: 30.sp,
//                     width: 30.sp,
//                     color: ColorPicker.grey,
//                   ),
//                 ),
//               ],
//             ),
//             StreamBuilder<QuerySnapshot>(
//               stream: searchController.text.isEmpty
//                   ? FirebaseFirestore.instance
//                       .collection("contact")
//                       .doc(FirebaseAuth.instance.currentUser!.uid)
//                       .collection("mobile_number")
//                       .orderBy("date_time", descending: true)
//                       .snapshots()
//                   : FirebaseFirestore.instance
//                       .collection("contact")
//                       .doc(FirebaseAuth.instance.currentUser!.uid)
//                       .collection("mobile_number")
//                       .where('firstName',
//                           isGreaterThanOrEqualTo: searchController.text)
//                       .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasData) {
//                   /// DECALARE THIS SNAPSHOT.HASHDATA AFTER
//                   var doc = snapshot.data!.docs;
//                   print("length======>${doc.length}");
//                   print("Text======>${searchText}");
//
//                   return Expanded(
//                     child: ListView.builder(
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       itemCount: snapshot.data?.docs.length,
//                       itemBuilder: (context, index) {
//                         ///GetData
//                         // final getData = doc[index];
//                         final getData1 = doc[index].id;
//                         PreferencesManager.setUid(getData1);
//                         print("PartiesScreen_Pre_uId$doc");
//
//                         return Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: InkWell(
//                             onTap: () {
//                               Get.to(CustomerData(
//                                 uid: getData1,
//                                 name: "${doc[index]["firstName"]}",
//                               ));
//                             },
//                             child: Dismissible(
//                               direction: DismissDirection.startToEnd,
//                               background: Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 28),
//                                 color: ColorPicker.red,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Icon(
//                                       Icons.delete,
//                                       color: ColorPicker.whiteColor,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               onDismissed: (direction) {
//                                 FirebaseFirestore.instance
//                                     .collection("contact")
//                                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                                     .collection("mobile_number")
//                                     .doc(doc[index].id)
//                                     .delete()
//                                     .then((value) =>
//                                         Get.showSnackbar(GetSnackBar(
//                                           duration: Duration(seconds: 2),
//                                           message: "successfully user delete",
//                                         )));
//                               },
//                               key: ValueKey("${doc[index]["firstName"]}"),
//                               child: Container(
//                                 color: ColorPicker.lightContainerColor,
//                                 height: 65.sp,
//                                 width: Get.width,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 10.0, right: 10),
//                                   child: Row(
//                                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           height: 50.sp,
//                                           width: 50.sp,
//                                           decoration: BoxDecoration(
//                                             color: ColorPicker.grey,
//                                             shape: BoxShape.circle,
//                                           ),
//                                         ),
//                                         CommonSizeBox.commonSize(width: 20.sp),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 17, bottom: 17),
//                                           child: Column(
//                                             children: [
//                                               Container(
//                                                 height: 15.sp,
//                                                 width: 100.sp,
//                                                 // color: Colors.red,
//                                                 child: showListText(
//                                                     text:
//                                                         "${doc[index]["firstName"]}",
//                                                     fontSize: 15.sp,
//                                                     overflow:
//                                                         TextOverflow.visible,
//                                                     maxline: 1,
//                                                     color: Colors.black
//                                                         .withOpacity(0.5)),
//                                               ),
//                                               Spacer(),
//                                               showListText(
//                                                   text:
//                                                       "${doc[index]["date_time"]}",
//                                                   color: Colors.black
//                                                       .withOpacity(0.3))
//                                             ],
//                                           ),
//                                         ),
//                                         Spacer(),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 17, bottom: 17),
//                                           child: Column(
//                                             children: [
//                                               showListText(
//                                                   text:
//                                                       "${doc[index]["gave_&_got_amount"]}",
//                                                   fontSize: 15.sp,
//                                                   color: doc[index]
//                                                               ["check_value"] ==
//                                                           true
//                                                       ? Colors.green
//                                                       : Colors.red),
//                                               Spacer(),
//                                               showListText(
//                                                   text: doc[index]
//                                                               ["check_value"] ==
//                                                           false
//                                                       ? "You will got"
//                                                       : "You will gave",
//                                                   color: doc[index]
//                                                               ["check_value"] ==
//                                                           false
//                                                       ? ColorPicker.red
//                                                       : ColorPicker.green),
//                                             ],
//                                           ),
//                                         )
//                                       ]),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             )
//           ],
//         ));
//   }
//
//   willGiveText({@required String? text, Color? color}) {
//     return Text(
//       text!,
//       style:
//           TextStyle(fontSize: 22.sp, color: color, fontWeight: FontWeight.w900),
//     );
//   }
//
//   viewReportText({@required String? text, Color? color, fontSize}) {
//     return Text(
//       '${text ?? 0}',
//       style: TextStyle(
//         fontSize: fontSize,
//         color: color,
//         fontWeight: FontWeight.w900,
//       ),
//     );
//   }
// }
