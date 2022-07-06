import 'package:flutter/material.dart';
import 'package:safe_khata_book/common/app_bar.dart';

class CustomerData extends StatefulWidget {
  const CustomerData({Key? key}) : super(key: key);

  @override
  State<CustomerData> createState() => _CustomerDataState();
}

class _CustomerDataState extends State<CustomerData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.customerAppData(),
    );
  }
}
