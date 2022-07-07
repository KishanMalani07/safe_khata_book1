import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_khata_book/view/auth/mobile_login.dart';

class SignOut {
  static Future<void> signOut() async {
    GetStorage getStorage = GetStorage();
    getStorage.erase();

    await FirebaseAuth.instance
        .signOut()
        .then((value) => Future.delayed(Duration(seconds: 1)))
        .then((value) => Get.to(MobileAuthScreen()));
  }
}
