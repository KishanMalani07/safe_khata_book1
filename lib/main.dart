import 'package:flutter/material.dart';
import 'package:safe_khata_book/view/auth/sign_up.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignUpScreen(),
      ),
    );
  }
}

///20-06
