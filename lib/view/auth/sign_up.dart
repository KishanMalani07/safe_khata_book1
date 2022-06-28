import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../common/app_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(children: [
          Center(
            child: Text(
              "Trusted By Businesses Across India",
              style: TextStyle(
                  fontSize: 10.sp, color: Colors.grey.withOpacity(1.0)),
            ),
          )
        ]),
      ),
    );
  }
}
