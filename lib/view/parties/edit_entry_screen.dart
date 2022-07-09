import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/custom_textField.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:safe_khata_book/common/text_style.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/button.dart';
import 'calander.dart';

class EditEntryScreen extends StatefulWidget {
  const EditEntryScreen({Key? key}) : super(key: key);

  @override
  State<EditEntryScreen> createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  ///Calender
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        print("selectedDate$selectedDate");
      });
  }

  @override
  void initState() {
    print("PrefeValue${PreferencesManager.getYouGave()}");
    // TODO: implement initState
    super.initState();
  }

  ///Calender
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBarCenterNameAndBackArrow(
          color: PreferencesManager.getYouGave() == 'youGave'
              ? ColorPicker.red
              : ColorPicker.green,
          text: "You Got \$ 440 from kishan"),
      body: Column(
        children: [
          /// Enter Amount
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Column(children: [
              Container(
                height: 50.sp,
                color: ColorPicker.lightContainerColor,
                child: CommonTextFiled.entryTextFiled(
                    inputFormatters: [],
                    controller: amountController,
                    hintText: "Enter Amount",
                    textInputType: TextInputType.number,
                    prefixIcon: Icon(
                      Icons.currency_rupee,
                      color: PreferencesManager.getYouGave() == 'youGave'
                          ? ColorPicker.red
                          : ColorPicker.green,
                    )),
              )
            ]),
          ),

          /// Enter Details
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Column(children: [
              Container(
                height: 50.sp,
                color: ColorPicker.lightContainerColor,
                child: CommonTextFiled.entryTextFiled(
                    inputFormatters: [],
                    controller: detailsController,
                    textInputType: TextInputType.text,
                    hintText: "Enter Details(Item,Name,Bill No)",
                    prefix: CommonSizeBox.commonSize(width: 10.0)),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Date Time Picker
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    height: 40.sp,
                    width: 130.sp,
                    color: ColorPicker.lightContainerColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: PreferencesManager.getYouGave() == 'youGave'
                                ? ColorPicker.red
                                : ColorPicker.green,
                          ),
                          CommonText.simpleText(
                              text: "date time now", color: ColorPicker.grey),
                          Icon(
                            Icons.arrow_drop_down,
                            color: PreferencesManager.getYouGave() == 'youGave'
                                ? ColorPicker.red
                                : ColorPicker.green,
                          )
                        ]),
                  ),
                ),

                ///Camera
                Container(
                  height: 40.sp,
                  width: 90.sp,
                  color: ColorPicker.lightContainerColor,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: PreferencesManager.getYouGave() == 'youGave'
                              ? ColorPicker.red
                              : ColorPicker.green,
                        ),
                        CommonText.simpleText(
                            text: "Attach bills", color: ColorPicker.grey),
                      ]),
                )
              ],
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {},
            child: Padding(
                padding: EdgeInsets.all(10),
                child: CommonButton.commonButton123(
                  text: "SAVE",
                  color: PreferencesManager.getYouGave() == 'youGave'
                      ? ColorPicker.red
                      : ColorPicker.green,
                )),
          )
        ],
      ),
    );
  }
}
