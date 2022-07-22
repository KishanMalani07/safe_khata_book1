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
  final userMap;

  const MessageRoomScreen({Key? key, this.name, this.chatRoomId, this.userMap})
      : super(key: key);

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
        "sendBy": FirebaseAuth.instance.currentUser!.uid,
        "message": _message.text,
        "type": "text",
        "time": f.format(DateTime.now()),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("contact")
          .doc(PreferencesManager.getUid())
          .collection("mobile_number")
          .orderBy("time", descending: false)
          // .doc(PreferencesManager.get_Get_Mobile_Uid()).
          // .collection("chat_message")
          // .orderBy("date_time", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        final getData = snapshot.data;
        if (snapshot.hasData != null) {
          return ListView.builder(
            itemCount: getData!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> map =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              return message(map, context);
            },
          );
        } else {
          return Center(child: Container());
        }
      },
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
  }
}

///return Scaffold(
//             appBar: AppBar(
//               // centerTitle: true,
//
//               backgroundColor: Colors.white,
//               title: Container(
//                 height: 35.sp,
//                 // width: 10.sp,
//                 decoration: BoxDecoration(
//                     // color: ColorPicker.red,
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.network(
//                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3WEmfJCME77ZGymWrlJkXRv5bWg9QQmQEzw&usqp=CAU",
//                           fit: BoxFit.contain),
//                       CommonSizeBox.commonSize(width: 10.0),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CommonText.simpleText(
//                               text: widget.name, color: ColorPicker.black),
//                           CommonText.simpleText(
//                               text: "online",
//                               color: ColorPicker.grey,
//                               fontSize: 10.sp)
//                         ],
//                       )
//                     ]),
//               ),
//               leading: InkWell(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Icon(
//                     Icons.arrow_back,
//                     color: ColorPicker.grey,
//                   )),
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: Stack(
//                     children: [],
//                   ),
//                 ),
//                 Positioned(
//                     bottom: 1,
//                     top: 100,
//                     child: Container(
//                         color: ColorPicker.lightContainerColor,
//                         child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 8, right: 10, top: 8, bottom: 8),
//                             child: CommonTextFiled.messageTextFiled(
//                                 inputFormatters: [],
//                                 prefixIcon: Icon(
//                                   Icons.person,
//                                   color: ColorPicker.black,
//                                 ),
//                                 hintText: "Message",
//                                 controller: _message,
//                                 suffixIcon: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(Icons.emoji_emotions),
//                                     CommonSizeBox.commonSize(width: 10.sp),
//                                     Icon(Icons.emoji_emotions)
//                                   ],
//                                 )))))
//               ],
//             ),
//           );
