import 'package:flutter/material.dart';
import 'package:safe_khata_book/common_method/sign_out.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: InkWell(
                onTap: () {
                  SignOut.signOut();
                },
                child: Icon(Icons.logout))));
  }
}
