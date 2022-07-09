import 'package:get/get.dart';

class BottomController extends GetxController {
  int bottomIndex = 0;
  String selectedScreen = "";

  void setIndex(int id) {
    bottomIndex = id;
    update();
  }

  void setSelectedScreen(String value) {
    selectedScreen = value;
    update();
  }
}
