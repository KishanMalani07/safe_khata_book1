import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_khata_book/common/preferences_manager.dart';
import 'package:safe_khata_book/logic%20screen.dart';
import 'package:safe_khata_book/view/auth/mobile_login.dart';
import 'package:safe_khata_book/view/bottom_bar/bottom_bar_screen.dart';
import 'package:safe_khata_book/view/parties/calander.dart';
import 'package:safe_khata_book/view/parties/customer_data_screen.dart';
import 'package:safe_khata_book/view/parties/edit_entry_screen.dart';
import 'package:safe_khata_book/view/parties/entry_details_screen.dart';
import 'package:safe_khata_book/view/parties/view_report_screen.dart';

import 'package:safe_khata_book/view_model/bottom_controller.dart';
import 'package:sizer/sizer.dart';

import 'view_model/save_data_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// check this already user login
  final getStorage = GetStorage();
  final uid = getStorage.read('uid');

  ///
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // statusBarColor: Colors.transparent,
    statusBarColor: Colors.white.withOpacity(1),
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp();
  // await GetStorage.init();

  ///firebase initiallize
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

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

        home: PreferencesManager.getUid() == null
            ? MobileAuthScreen()
            : BottomBarScreen(),
        // home: ViewReportScreen(),
        // home: BottomBarScreen(),
        // home: CustomerData(),

        // home: VerifyOtpScreen(),
      ),
    );
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomController(), fenix: true);
    Get.lazyPut(() => SaveDataEntryController(), fenix: true);
    // TODO: implement dependencies
  }
}
