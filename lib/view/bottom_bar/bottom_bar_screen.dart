import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:safe_khata_book/view/money/money_screen%5D.dart';
import 'package:safe_khata_book/view/more/more_screen.dart';
import 'package:safe_khata_book/view/parties/parties_screen.dart';
import 'package:safe_khata_book/view_model.dart';
import 'package:sizer/sizer.dart';

List<Widget> tabPage = [PartiesScreen(), MoneyScreen(), MoreScreen()];
List<Map<String, dynamic>> bottomBarData = [
  {
    "title": "Parties",
    "Icon": "assets/svg/person_4_FILL0_wght400_GRAD0_opsz48.svg",
  },
  {
    "title": "Money",
    "Icon": "assets/svg/currency_rupee_FILL0_wght400_GRAD0_opsz48.svg"
  },
  {
    "title": "More",
    "Icon": "assets/svg/more_horiz_FILL0_wght400_GRAD0_opsz48.svg",
  },
];

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  BottomController _bottomBar = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: buildBottomBar(bottomController: _bottomBar),
          backgroundColor: Colors.grey,
          body: _bottomBar.selectedScreen != ''
              ? _bottomBar.bottomIndex == 0
                  ? PartiesScreen()
                  : _bottomBar.bottomIndex == 1
                      ? MoneyScreen()
                      : _bottomBar.bottomIndex == 2
                          ? MoreScreen()
                          : PartiesScreen()
              : tabPage[_bottomBar.bottomIndex]),
    );
  }

  Widget buildBottomBar({required BottomController bottomController}) {
    return Container(
      padding: EdgeInsets.only(bottom: 20, top: 4),
      // height: Platform.isIOS ? 100.sp : 50.sp,
      width: Get.width,
      height: Get.height * 0.08,
      decoration: BoxDecoration(
          color: bottomController.selectedScreen == 'BottomBar'
              ? Colors.red
              : ColorPicker.lightContainerColor,
          border: Border(
              top: BorderSide(
            //                   <--- left side
            color: bottomController.selectedScreen == 'BottomBar'
                ? Colors.red
                : ColorPicker.whiteColor.withOpacity(0.2),
            //  width: 3.0,
          ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: bottomBarData
            .map((e) => InkResponse(
                  onTap: () {
                    setState(() {});
                    onTabTapped(bottomBarData.indexOf(e));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          child: SvgPicture.asset(
                            e["Icon"],
                            height: 20,
                            width: 16,
                            color: bottomController.bottomIndex ==
                                    bottomBarData.indexOf(e)
                                ? Colors.black
                                : Colors.white,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "${e["title"]}",
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: bottomController.bottomIndex ==
                                    bottomBarData.indexOf(e)
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  void onTabTapped(int index) {
    _bottomBar.bottomIndex = index;
    print('========--- ${_bottomBar.bottomIndex}');
    if (index == 0) {
      _bottomBar.setIndex(0);
    }
    if (index == 1) {
      _bottomBar.setIndex(1);
    }

    if (index == 2) {
      _bottomBar.setIndex(2);
    }
  }
}
