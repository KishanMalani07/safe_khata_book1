import 'package:get/get.dart';

class SaveDataEntryController extends GetxController {
  List _saveData = [];

  List get saveData => _saveData;

  set saveData(List value) {
    _saveData = value;
    update();
  }
}
