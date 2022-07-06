import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_khata_book/view/auth/mobile_login.dart';

import 'package:safe_khata_book/view_model.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white.withOpacity(1),
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp();
  // await GetStorage.init();

  ///firebase initiallize
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: BaseBindings(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: PartiesScreen(),
        home: MobileAuthScreen(),
        // home: VerifyOtpScreen(),
      ),
    );
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomController(), fenix: true);
    // TODO: implement dependencies
  }
}
