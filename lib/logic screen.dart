import 'package:flutter/material.dart';
import 'package:safe_khata_book/common/text.dart';

class LogicScreen extends StatefulWidget {
  const LogicScreen({Key? key}) : super(key: key);

  @override
  State<LogicScreen> createState() => _LogicScreenState();
}

class _LogicScreenState extends State<LogicScreen> {
  DateTime currentDate = DateTime.now();
  String difference = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Text(difference),
        ],
      ),
    );
  }
}
