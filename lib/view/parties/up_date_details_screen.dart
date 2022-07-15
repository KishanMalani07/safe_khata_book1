import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:safe_khata_book/common/app_bar.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/custom_textField.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:sizer/sizer.dart';
import '../../common/button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../common/snackBar.dart';

class UpDateDetailsScreen extends StatefulWidget {
  final id;
  final userDataId;
  // final bool;

  const UpDateDetailsScreen({
    super.key,
    this.id,
    this.userDataId,
    // this.bool,
  });

  @override
  State<UpDateDetailsScreen> createState() => _UpDateDetailsScreenState();
}

class _UpDateDetailsScreenState extends State<UpDateDetailsScreen> {
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

  /// Date format
  final f = new DateFormat('dd-MM-yyyy hh:mm');

  ///==========FutureMethod======///

  File? _image;
  final picker = ImagePicker();

  final ImagePicker _picker = ImagePicker();

  Future getGalleryImage() async {
    var imageGa = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (imageGa != null) {
        _image = File(imageGa.path);
        print("=============ImagePath0==========${imageGa.path}");
        imageCache.clear();
      } else {
        print('no image selected');
      }
    });
  }

  Future getCamaroImage() async {
    // var imaGe = await picker.getImage(source: ImageSource.camera);
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    print("==========ImagePath1=============${photo!.path}");
    setState(() {
      if (photo != null) {
        _image = File(
          photo.path,
        );
        print("===========ImagePath============${_image}");
        print("=============ImagePath==========${photo.path}");

        imageCache.clear();
      } else {
        print('no image selected');
      }
    });
  }

  Future<dynamic> uploadImageToFirebase(
      {required BuildContext contex, String? fileName, file}) async {
    try {
      var response = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putFile(file!);
      print("Response>>>>>>>>>>>>>>>>>>$response");

      return response.storage.ref('uploads/$fileName').getDownloadURL();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    widget.userDataId;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBarCenterNameAndBackArrow(text: ""),
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
                      color: ColorPicker.grey,
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
                    width: 150.sp,
                    color: ColorPicker.lightContainerColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: ColorPicker.grey,
                          ),
                          CommonText.simpleText(
                              text: "${f.format(selectedDate)}",
                              color: ColorPicker.grey,
                              overflow: TextOverflow.visible),
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
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                children: [
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: MaterialButton(
                                            child: Text(
                                              'gallery',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Get.back();
                                              getGalleryImage();
                                            },
                                          ),
                                          width: 220,
                                          height: 60,
                                          color: ColorPicker.grey,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: MaterialButton(
                                            child: Text(
                                              'camera',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            // color: Colors.deepOrange,
                                            onPressed: () {
                                              Get.back();
                                              getCamaroImage();
                                            },
                                          ),
                                          width: 220,
                                          height: 60,
                                          color: ColorPicker.grey,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: ColorPicker.grey,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 60,
                          color: Colors.transparent,
                          child: _image == null
                              ? Center(
                                  child: CommonText.simpleText(
                                      text: "Attach bills",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      color: ColorPicker.grey),
                                )
                              : Image.file(_image!),
                        ),
                      ]),
                )
              ],
            ),
          ),

          Spacer(),
          InkWell(
            onTap: () async {
              String url = await uploadImageToFirebase(
                      contex: context,
                      file: _image,
                      fileName: "${Random().nextInt(1234)}") ??
                  "";

              if (amountController.text == null ||
                  amountController.text.isNotEmpty) {
                FirebaseFirestore.instance
                    .collection("mobile_number")
                    .doc(widget.id)
                    .collection("user_data")
                    .doc(widget.userDataId)
                    .update({
                  "gave_&_got_amount": amountController.text,
                  "details": detailsController.text,
                  "date_time": selectedDate.toString(),
                  "image_url": url,
                }).then((value) => Get.back());
              } else {
                Get.showSnackbar(GetSnackBar(
                  message: "please enter you amount",
                ));
              }
            },
            child: Padding(
                padding: EdgeInsets.all(10),
                child: CommonButton.commonButton123(
                  text: "UpData",
                  color: ColorPicker.grey,
                )),
          )
        ],
      ),
    );
  }
}
