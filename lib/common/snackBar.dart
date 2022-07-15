import 'package:get/get.dart';
import 'package:safe_khata_book/common/color.dart';

class CommonSnackBar {
  static void showSnackBar({String? msg}) {
    Get.showSnackbar(GetBar(
      message: msg,
      duration: Duration(seconds: 1),
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorPicker.lightContainerColor,
    ));
  }
}
