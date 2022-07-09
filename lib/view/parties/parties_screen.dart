import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/custom_textField.dart';
import 'package:safe_khata_book/view/parties/customer_data_screen.dart';
import 'package:sizer/sizer.dart';

class PartiesScreen extends StatefulWidget {
  const PartiesScreen({Key? key}) : super(key: key);

  @override
  State<PartiesScreen> createState() => _PartiesScreenState();
}

class _PartiesScreenState extends State<PartiesScreen> {
  /// current time
  todayDate() {
    // var now = new DateTime.now();
    // var formatter = new DateFormat('dd-MM-yyyy');
    // String formattedTime = DateFormat('kk:mm:a').format(now);
    // String formattedDate = formatter.format(now);
    // print(formattedTime);
    // print(formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: InkWell(
          onTap: () async {
            final FullContact contact =
                await FlutterContactPicker.pickFullContact();
            print("contact123${contact}");

            Map<String, String> getContact = {
              "firstName": "${contact.name!.firstName}",
              "number": "${contact.phones[0].number}",
              "profile_picture": "${contact.photo}",
            };
            print("getContact-----------------$getContact");

            FirebaseFirestore.instance
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
                            text: "\$ 2000000",
                            color: Colors.green,
                          ),
                          Text(
                            "You will give",
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
                          willGiveText(text: "\$ 1000000", color: Colors.red),
                          Text(
                            "You will gate",
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
                    child: viewReportText(
                        text: ("View Report"),
                        color: ColorPicker.grey,
                        fontSize: 15.sp),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                      width: 180.sp,
                      child: CommonTextFiled.otpTextFiled(
                          hintText: "Search",
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
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("mobile_number")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  ///GetData
                  final doc = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: doc.length,
                    itemBuilder: (context, index) {
                      ///GetData
                      final getData = doc[index];

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(CustomerData(
                              name: "${getData["firstName"]}",
                            ));
                          },
                          child: Container(
                            color: ColorPicker.lightContainerColor,
                            height: 65.sp,
                            width: Get.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                                          showListText(
                                              text: "${getData["firstName"]}",
                                              fontSize: 15.sp,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                          Spacer(),
                                          showListText(
                                              text: "time",
                                              color: Colors.black
                                                  .withOpacity(0.3)),
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
                                              text: "1000",
                                              fontSize: 15.sp,
                                              color: index.isEven
                                                  ? Colors.red
                                                  : Colors.green),
                                          Spacer(),
                                          showListText(
                                              text: "You will give",
                                              color: Colors.black
                                                  .withOpacity(0.3)),
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ))
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

  showListText({@required String? text, Color? color, fontSize}) {
    return Text(
      "${text ?? 0}",
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
