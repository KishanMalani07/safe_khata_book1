import 'package:get/get.dart';

class SaveDataEntryController extends GetxController {
  String? _saveAmount;

  String get saveAmount => _saveAmount!;

  set saveAmount(String value) {
    _saveAmount = value;
  }

  String? _saveStatusCheck;

  String get saveStatusCheck => _saveStatusCheck!;

  set saveStatusCheck(String value) {
    _saveStatusCheck = value;
  }

  ///=====
  String? _userMap;

  String get userMap => _userMap!;

  set userMap(String value) {
    _userMap = value;
    update();
  }
}
