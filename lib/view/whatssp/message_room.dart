import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/common/common_sizebox.dart';
import 'package:safe_khata_book/common/custom_textField.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:safe_khata_book/common/text.dart';
import 'package:sizer/sizer.dart';

class MessageRoomScreen extends StatefulWidget {
  final name;
  final chatRoomId;

  const MessageRoomScreen({
    Key? key,
    this.name,
    this.chatRoomId,
  }) : super(key: key);

  @override
  State<MessageRoomScreen> createState() => _MessageRoomScreenState();
}

class _MessageRoomScreenState extends State<MessageRoomScreen> {
  ///============ChatRoom============///
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _message = TextEditingController();

  /// Date format
  final f = new DateFormat('dd-MM-yyyy hh:mm');

  ///message
  void sendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> message = {
        "sendBy": PreferencesManager.getUid(),
        "message": _message.text,
        "type": "text",
        "date_time": f.format(DateTime.now()),
      };

      FirebaseFirestore.instance
          .collection("chat_room")
          .doc(widget.chatRoomId)
          .collection("chat")
          .add(message);
      _message.clear();
    }
  }

  /// set status
  setStatus(String status) async {
    await FirebaseFirestore.instance
        .collection("contact")
        .doc(PreferencesManager.getUid())
        .update({"message_status": status});
  }

  @override
  void initState() {
    setStatus("Online");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Container(
          height: 35.sp,
          // width: 10.sp,
          decoration: BoxDecoration(
              // color: ColorPicker.red,
              borderRadius: BorderRadius.circular(8)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3WEmfJCME77ZGymWrlJkXRv5bWg9QQmQEzw&usqp=CAU",
                fit: BoxFit.contain),
            CommonSizeBox.commonSize(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.simpleText(
                    text: widget.name, color: ColorPicker.black),
                CommonText.simpleText(
                    text: "online", color: ColorPicker.grey, fontSize: 10.sp)
              ],
            )
          ]),
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: ColorPicker.grey,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              // height: 525.sp,
              // color: ColorPicker.red,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chat_room")
                    .doc(widget.chatRoomId)
                    .collection("chat")
                    .orderBy("date_time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    return Scrollbar(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return CommonText.simpleText(
                              text: '${snapshot.data!.docs[index]['message']}',
                              color: ColorPicker.whiteColor);
                        },
                      ),
                    );
                  } else {
                    return Center(child: Container());
                  }
                },
              ),
            ),
            Spacer(),
            Row(
              children: [
                CommonSizeBox.commonSize(width: 10.0),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _message,
                    decoration: InputDecoration(
                      // suffixIcon: Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      //   child: PopupMenuButton(
                      //     icon: RotatedBox(
                      //         quarterTurns: 1,
                      //         child: Icon(
                      //           Icons.attach_file,
                      //           color: Colors.white,
                      //           size: 4.h,
                      //         )),
                      //     itemBuilder: (BuildContext context) {
                      //       return [
                      //         // PopupMenuItem(
                      //         //   child: GestureDetector(
                      //         //     onTap: () {
                      //         //       print("====>>  Image Sent");
                      //         //
                      //         //       getImage();
                      //         //     },
                      //         //     child: Row(
                      //         //       children: [
                      //         //         Icon(
                      //         //           Icons.photo,
                      //         //           size: 2.h,
                      //         //           color: Colors.black,
                      //         //         ),
                      //         //         SizedBox(
                      //         //           width: 2.w,
                      //         //         ),
                      //         //         Text("Image")
                      //         //       ],
                      //         //     ),
                      //         //   ),
                      //         // ),
                      //         // PopupMenuItem(
                      //         //   child: GestureDetector(
                      //         //     onTap: () {
                      //         //       print("====>>  Video Sent");
                      //         //       getVideo();
                      //         //     },
                      //         //     child: Row(
                      //         //       children: [
                      //         //         Icon(
                      //         //           Icons.video_camera_back_outlined,
                      //         //           size: 2.h,
                      //         //           color: Colors.black,
                      //         //         ),
                      //         //         SizedBox(
                      //         //           width: 2.w,
                      //         //         ),
                      //         //         Text("Video")
                      //         //       ],
                      //         //     ),
                      //         //   ),
                      //         // ),
                      //         // PopupMenuItem(
                      //         //   child: GestureDetector(
                      //         //     onTap: () {
                      //         //       print("====>>  audio Sent");
                      //         //       getAudio();
                      //         //     },
                      //         //     child: Row(
                      //         //       children: [
                      //         //         Icon(
                      //         //           Icons.audiotrack,
                      //         //           size: 2.h,
                      //         //           color: Colors.black,
                      //         //         ),
                      //         //         SizedBox(
                      //         //           width: 2.w,
                      //         //         ),
                      //         //         Text("Audio")
                      //         //       ],
                      //         //     ),
                      //         //   ),
                      //         // ),
                      //         // PopupMenuItem(
                      //         //   child: GestureDetector(
                      //         //     onTap: () {
                      //         //       print("====>>  document Sent");
                      //         //       getFile();
                      //         //     },
                      //         //     child: Row(
                      //         //       children: [
                      //         //         Icon(
                      //         //           Icons.file_copy,
                      //         //           size: 2.h,
                      //         //           color: Colors.black,
                      //         //         ),
                      //         //         SizedBox(
                      //         //           width: 2.w,
                      //         //         ),
                      //         //         Text("Document")
                      //         //       ],
                      //         //     ),
                      //         //   ),
                      //         // )
                      //       ];
                      //     },
                      //   ),
                      // ),
                      hintText: "Send Message",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: IconButton(
                    onPressed: () {
                      print("====> Message Sent");
                      sendMessage();
                    },
                    icon: Icon(
                      color: Colors.white,
                      Icons.send,
                      size: 4.h,
                    ),
                  ),
                )
              ],
            ),
            CommonSizeBox.commonSize(height: 15.0)
          ],
        ),
      ),
    );
  }

  Widget message(Map<String, dynamic> map, BuildContext context) {
    return map["type"] == ["text"]
        ? Container(
            width: 100.sp,
            alignment: map['sendBy'] == FirebaseAuth.instance.currentUser!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // margin: map['sendBy'] == kFirebaseAuth.currentUser!.displayName
                    //     ? EdgeInsets.only(left: 30)
                    //     : EdgeInsets.only(right: 30),
                    padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: map['sendBy'] ==
                                FirebaseAuth.instance.currentUser!.displayName
                            ? 24
                            : 10,
                        right: map['sendBy'] ==
                                FirebaseAuth.instance.currentUser!.displayName
                            ? 10
                            : 24),
                    decoration: BoxDecoration(
                      borderRadius: map['sendBy'] ==
                              FirebaseAuth.instance.currentUser!.displayName
                          ? BorderRadius.only(
                              topLeft: Radius.circular(23),
                              topRight: Radius.circular(23),
                              bottomLeft: Radius.circular(23))
                          : BorderRadius.only(
                              topLeft: Radius.circular(23),
                              topRight: Radius.circular(23),
                              bottomRight: Radius.circular(23)),
                      color: map['sendBy'] ==
                              FirebaseAuth.instance.currentUser!.displayName
                          ? Color(0xff004D40)
                          : Color(0xfffafafa),
                    ),
                    child: Text(
                      map['message'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: map['sendBy'] ==
                                FirebaseAuth.instance.currentUser!.displayName
                            ? Color(0xfffafafa)
                            : Color(0xff004D40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
    ;
  }
}
