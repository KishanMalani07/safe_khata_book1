import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/button.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:sizer/sizer.dart';

import '../../c_widget/widget.dart';
import '../../common/custom_textField.dart';

class ViewReportScreen extends StatefulWidget {
  const ViewReportScreen({Key? key}) : super(key: key);

  @override
  State<ViewReportScreen> createState() => _ViewReportScreenState();
}

class _ViewReportScreenState extends State<ViewReportScreen> {
  final f = new DateFormat('dd-MM-yyyy hh:mm');
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50.sp,
        color: ColorPicker.whiteColor,
        child: CommonButton.commonButton123(
            text: "PDF DOWNLOAD", color: ColorPicker.blue),
      ),
      appBar: CommonAppBar.appBarCenterNameAndBackArrow(
          text: "ViewReport", color: ColorPicker.grey),
      body: Column(children: [
        ///1sT container
        Container(
          color: ColorPicker.lightContainerColor,
          height: 135.sp,
          width: Get.width,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 22.5, right: 22.5, top: 20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40.sp,
                      width: 130.sp,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month, color: ColorPicker.grey),
                            CommonSizeBox.commonSize(width: 10.sp),
                            CommonText.simpleText(
                                text: "date", color: ColorPicker.grey)
                          ]),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40.sp,
                      width: 130.sp,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month, color: ColorPicker.grey),
                            CommonSizeBox.commonSize(width: 10.sp),
                            CommonText.simpleText(
                                text: "date", color: ColorPicker.grey)
                          ]),
                    ),
                  ],
                ),
              ),
              CommonSizeBox.commonSize(height: 10.sp),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 25),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(),
                      child: SizedBox(
                          width: 156.sp,
                          child: CommonTextFiled.otpTextFiled(
                              controller: searchController,
                              onChange: (value) {},
                              hintText: "Search",
                              suffixIcon: Icon(Icons.clear),
                              prefix: SizedBox(width: 15),
                              inputFormatters: [],
                              textInputType: TextInputType.text)),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          // color: Colors.grey,
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40.sp,
                      width: 100.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        ///Net Balance
        Container(
          height: 30.sp,
          color: ColorPicker.grey.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(children: [
              CommonText.simpleText(
                  text: "Net Balance",
                  color: ColorPicker.grey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
              Spacer(),
              CommonText.simpleText(
                  text: "\$ 10000",
                  color: ColorPicker.green,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ]),
          ),
        ),
        CommonSizeBox.commonSize(height: 01.0),

        ///Total
        Container(
          height: 50.sp,
          color: ColorPicker.grey.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(children: [
              /// entries
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                child: Column(
                  children: [
                    CommonText.simpleText(
                        text: "Total",
                        color: ColorPicker.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp),
                    Spacer(),
                    CommonText.simpleText(
                        text: "Entries",
                        color: ColorPicker.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp)
                  ],
                ),
              ),
              CommonSizeBox.commonSize(width: 80.sp),

              /// entries
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                child: Column(
                  children: [
                    CommonText.simpleText(
                        text: "Total",
                        color: ColorPicker.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp),
                    Spacer(),
                    CommonText.simpleText(
                        text: "\$ 10000",
                        color: ColorPicker.red,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp)
                  ],
                ),
              ),
              Spacer(),

              /// entries
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                child: Column(
                  children: [
                    CommonText.simpleText(
                        text: "Total",
                        color: ColorPicker.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp),
                    Spacer(),
                    CommonText.simpleText(
                        text: "\$ 10000",
                        color: ColorPicker.green,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp)
                  ],
                ),
              ),
            ]),
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
                    // Get.to(CustomerData(
                    //   uid: getData1,
                    //   name: "${doc[index]["firstName"]}",
                    // ));
                  },
                  child: Container(
                    color: ColorPicker.lightContainerColor,
                    height: 65.sp,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
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
                              padding:
                                  const EdgeInsets.only(top: 17, bottom: 17),
                              child: Column(
                                children: [
                                  Container(
                                    height: 15.sp,
                                    width: 100.sp,
                                    // color: Colors.red,
                                    child: showListText(
                                        text: "First Name",
                                        fontSize: 15.sp,
                                        overflow: TextOverflow.visible,
                                        maxline: 1,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                  Spacer(),
                                  showListText(
                                      text: "${f.format(DateTime.now())}",
                                      color: Colors.black.withOpacity(0.3))
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 17, bottom: 17),
                              child: Column(
                                children: [
                                  showListText(
                                      text: "15500",
                                      // "${doc[index]["gave_&_got_amount"]}",
                                      fontSize: 15.sp,
                                      color:
                                          // doc[index]
                                          // ["check_value"] ==
                                          //     true
                                          //     ? Colors.green
                                          //     :
                                          Colors.red),
                                  Spacer(),
                                  showListText(
                                      text:
                                          // doc[index]
                                          // ["check_value"] ==
                                          //     false
                                          //     ? "You will got"
                                          //     :
                                          "You will gave",
                                      color:
                                          // doc[index]
                                          // ["check_value"] ==
                                          //     false
                                          //     ? ColorPicker.red
                                          //     :
                                          ColorPicker.green),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
