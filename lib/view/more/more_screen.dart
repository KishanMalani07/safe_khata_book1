import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:sizer/sizer.dart';

import '../auth/mobile_login.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.whiteColor,
      appBar: PreferredSize(
          child: Container(
            width: Get.width,
            height: Get.height * 0.11,
            color: ColorPicker.whiteColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 20),
              child: Row(children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.book_online_rounded,
                        color: ColorPicker.black,
                      ),
                      CommonText.simpleText(
                          text: "Name", color: ColorPicker.black),
                      Icon(
                        Icons.arrow_drop_down,
                        color: ColorPicker.black,
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ]),
            ),
          ),
          preferredSize: Size.fromHeight(30.sp)),
      body: Column(children: [
        ///edit
        Container(
          height: 60.sp,
          color: ColorPicker.lightContainerColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Row(children: [
              Container(
                height: 40.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                    color: ColorPicker.grey,
                    borderRadius: BorderRadius.circular(50)),
              ),
              // CommonSizeBox.commonSize(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    CommonText.simpleText(
                        text: "Kishan",
                        color: ColorPicker.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400),
                    Spacer(),
                    CommonText.simpleText(
                        text: "kishanmlani",
                        color: ColorPicker.black,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w300),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 25.sp,
                width: 50.sp,
                child: Center(
                  child: CommonText.simpleText(
                      text: "Edit", color: ColorPicker.black),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // color: ColorPicker.grey,
                    border: Border.all(
                      color: ColorPicker.black,
                      width: 1,
                    )),
              ),
            ]),
          ),
        ),
        CommonSizeBox.commonSize(height: 5.sp),

        ///request money
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 85.sp,
                width: 90.sp,
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
                              "assets/svg/typcn_business-card.svg",
                              color: ColorPicker.black,
                              fit: BoxFit.contain,
                            )),
                        Spacer(),
                        CommonText.simpleText(
                            text: "Business\n   Card", color: ColorPicker.black)
                      ]),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 85.sp,
                width: 90.sp,
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
                              "assets/svg/book.svg",
                              color: ColorPicker.black,
                              fit: BoxFit.contain,
                            )),
                        Spacer(),
                        CommonText.simpleText(
                            text: " CashBook", color: ColorPicker.black),
                        Spacer()
                      ]),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 85.sp,
                width: 90.sp,
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
                              "assets/svg/money_earn.svg",
                              color: ColorPicker.black,
                              fit: BoxFit.contain,
                            )),
                        Spacer(),
                        CommonText.simpleText(
                            text: " Earn\nMoney", color: ColorPicker.black)
                      ]),
                ),
              ),
            ),
          ],
        ),
        CommonSizeBox.commonSize(height: 10.0),
        container(
            icon: Icon(
              Icons.settings,
            ),
            title: "Setting"),
        CommonSizeBox.commonSize(height: 10.0),
        container(
          icon: Icon(Icons.help),
          title: "Help & Support",
        ),
        CommonSizeBox.commonSize(height: 10.0),
        container(icon: Icon(Icons.adjust_rounded), title: "About Us"),

        ///collection pending money

        Spacer(),
        InkWell(
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) => MobileAuthScreen());
          },
          child: CommonText.simpleText(text: "SignOut"),
        ),
        CommonText.simpleText(
            text:
                "All payments are 100% Safe and Secure on \n\n                       SAFEKHATABOOK",
            color: ColorPicker.grey),
        CommonSizeBox.commonSize(height: 15.0),
      ]),
    );
  }

  Widget container({Widget? icon, String? title}) {
    return Container(
      height: 40.sp,
      color: ColorPicker.lightContainerColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 20.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            child: icon!,
            width: 30.sp,
            height: 30.sp,
          ),
          CommonSizeBox.commonSize(width: 20.0),
          Expanded(
              child: CommonText.simpleText(
                  text: title,
                  textAlign: TextAlign.start,
                  color: ColorPicker.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w300)),
          // Spacer(),
          CommonSizeBox.commonSize(width: 140.0),
          Icon(
            Icons.arrow_right_alt_rounded,
            color: ColorPicker.black,
            size: 20.sp,
          )
        ]),
      ),
    );
  }
}
