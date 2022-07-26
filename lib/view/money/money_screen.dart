import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:sizer/sizer.dart';

class MoneyScreen extends StatefulWidget {
  const MoneyScreen({Key? key}) : super(key: key);

  @override
  State<MoneyScreen> createState() => _MoneyScreenState();
}

class _MoneyScreenState extends State<MoneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.whiteColor,
      appBar: CommonAppBar.containerAppData(ontap: () {}),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(children: [
          /// Add bank account
          InkWell(
            onTap: () {},
            child: Container(
              height: 60.sp,
              child: Row(
                children: [
                  Spacer(),
                  CommonText.simpleText(
                      text: "Add your bank account",
                      color: ColorPicker.green,
                      fontSize: 15.sp),
                  Spacer()
                ],
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTocgkC059e0FcgZ7OIMkNxdxyFENJcnPC8zw&usqp=CAU"))),
            ),
          ),
          CommonSizeBox.commonSize(height: 5.sp),

          ///payment history
          Container(
            height: 80.sp,
            color: ColorPicker.lightContainerColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 15, top: 10, bottom: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        CommonText.simpleText(
                            text: "Payment History",
                            color: ColorPicker.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp),
                        Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        CommonText.simpleText(
                            text: "\$ 0",
                            color: ColorPicker.green,
                            fontWeight: FontWeight.w400,
                            fontSize: 17.sp),
                        Spacer(),
                        CommonText.simpleText(
                            text: "VIEW >",
                            color: ColorPicker.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp),
                      ],
                    ),
                    Row(
                      children: [
                        CommonText.simpleText(
                            text: "Collected from 0 payments",
                            color: ColorPicker.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp),
                        Spacer(),
                      ],
                    ),
                  ]),
            ),
          ),
          CommonSizeBox.commonSize(height: 10.0),

          ///request money
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  height: 85.sp,
                  width: 80.sp,
                  color: ColorPicker.lightContainerColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30.sp,
                              width: 30.sp,
                              child: SvgPicture.asset(
                                "assets/svg/money-request.svg",
                                color: ColorPicker.black,
                                fit: BoxFit.contain,
                              )),
                          Spacer(),
                          CommonText.simpleText(
                              text: "Request\n Money", color: ColorPicker.black)
                        ]),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 85.sp,
                  width: 80.sp,
                  color: ColorPicker.lightContainerColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30.sp,
                              width: 30.sp,
                              child: SvgPicture.asset(
                                "assets/svg/send_money.svg",
                                color: ColorPicker.black,
                                fit: BoxFit.contain,
                              )),
                          Spacer(),
                          CommonText.simpleText(
                              text: " Send\nMoney", color: ColorPicker.black)
                        ]),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 85.sp,
                  width: 80.sp,
                  color: ColorPicker.lightContainerColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30.sp,
                              width: 30.sp,
                              child: SvgPicture.asset(
                                "assets/svg/scanner.svg",
                                color: ColorPicker.black,
                                fit: BoxFit.contain,
                              )),
                          Spacer(),
                          CommonText.simpleText(
                              text: "Order QR\n    Code",
                              color: ColorPicker.black)
                        ]),
                  ),
                ),
              ),
            ],
          ),
          CommonSizeBox.commonSize(height: 10.0),

          ///collection pending money
          Container(
            height: 60.sp,
            color: ColorPicker.lightContainerColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(children: [
                Icon(
                  Icons.calendar_month,
                  color: ColorPicker.black,
                  size: 30,
                ),
                // CommonSizeBox.commonSize(width: 10.0),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      CommonText.simpleText(
                          text: "Collection pending money",
                          color: ColorPicker.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400),
                      Spacer(),
                      CommonText.simpleText(
                          text: "\$ 200000 is with 8 customer",
                          color: ColorPicker.grey,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w300),
                    ],
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_right,
                  color: ColorPicker.black,
                  size: 30.sp,
                )
              ]),
            ),
          ),
          CommonSizeBox.commonSize(height: 50.0),
          CommonText.simpleText(
              text:
                  "All payments are 100% Safe and Secure on \n\n                       SAFEKHATABOOK",
              color: ColorPicker.grey)
        ]),
      ),
    );
  }
}
