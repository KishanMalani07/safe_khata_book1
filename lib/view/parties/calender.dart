import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_khata_book/common/color.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/text_style.dart';

class MyScheduleScreen extends StatefulWidget {
  @override
  State<MyScheduleScreen> createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen>
    with AutomaticKeepAliveClientMixin<MyScheduleScreen> {
  bool? switchSelected = false;
  var tabs = ['Calender', 'List View'];
  int? focusSelected = 0;

  DateTime _focusedDay = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  Map<DateTime, List> _eventsList = {};

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;

    _eventsList = {
      DateTime.now(): [
        {
          'title': 'Chest and Back Blast',
          'subtitle': 'Day 1 - Chest and Traps'
        },
        {'title': 'Legs', 'subtitle': ' Day 2 - Legs'},
        {
          'title': 'Biceps and Shoulder',
          'subtitle': 'Day 3 - Biceps and Shoulder'
        },
        {'title': 'Killer Core', 'subtitle': 'Day 4 - Killer Core'}
      ],
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List _getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.red,
            )),
        backgroundColor: Colors.black,
        title: Text(
          'My Schedule',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.02),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .03),
                child: TableCalendar(
                  calendarStyle: CalendarStyle(
                      markerSize: 0,
                      outsideDaysVisible: false,
                      weekendTextStyle: FontTextStyle.kWhite17W400Roboto,
                      defaultTextStyle: FontTextStyle.kWhite17W400Roboto,
                      selectedTextStyle: FontTextStyle.kBlack18w600Roboto,
                      selectedDecoration: BoxDecoration(
                          color: ColorPicker.blue, shape: BoxShape.circle),
                      // todayTextStyle:
                      // FontTextStyle.kWhite17W400Roboto,
                      todayDecoration: BoxDecoration(
                        color: Colors.transparent,
                      )),
                  daysOfWeekHeight: Get.height * .05,
                  daysOfWeekStyle: DaysOfWeekStyle(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ColorUtils.kGray)),
                      weekdayStyle: FontTextStyle.kWhite17W400Roboto,
                      weekendStyle: FontTextStyle.kWhite17W400Roboto),
                  headerStyle: HeaderStyle(
                    titleTextStyle: FontTextStyle.kWhite20BoldRoboto,
                    leftChevronIcon: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: ColorUtils.kTint,
                      size: Get.height * 0.025,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: ColorUtils.kTint,
                      size: Get.height * 0.025,
                    ),
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  availableGestures: AvailableGestures.horizontalSwipe,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2018, 01, 01),
                  lastDay: DateTime.utc(2030, 12, 31),
                  calendarFormat: _calendarFormat,
                  eventLoader: _getEventForDay,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        print("_selectedDay$_selectedDay");
                        print("_focusedDay$_focusedDay");
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    focusedDay = focusedDay;
                  },
                ),
              ),
              Divider(
                color: ColorUtils.kTint,
                thickness: 1.5,
                height: Get.height * 0.04,
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: _getEventForDay(_selectedDay!)
                    .map((event) => ListTile(
                          title: Text(
                            event['title'].toString(),
                            style: FontTextStyle.kWhite17BoldRoboto,
                          ),
                          subtitle: Text(
                            event['subtitle'].toString(),
                            style: FontTextStyle.kLightGray16W300Roboto,
                          ),
                          trailing: Icon(
                            Icons.more_horiz_sharp,
                            color: ColorUtils.kTint,
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorUtils {
  static Color kTint = Color(0xffC9AB83);
  static Color kBlack = Color(0xff171717);
  static Color kGray = Color(0xff505050);
  static Color kSaperatedGray = Color(0xff404040);
  static Color kLightGray = Color(0xffA7A7A7);
  static Color kRed = Color(0xffCE3F3F);
  static Color kWhite = Color(0xffffffff);
  static Color kBottomSheetGray = Color(0xff979797);
  static Color kAlertDialogGray = Color(0xffF2F2F2);
  static Color kHintTextGray = Color(0xff6E6E6E);
  static Color kBlue = Color(0xff0A84FF);
}

class ColorUtilsGradient {
  static List<Color> kTintGradient = [Color(0xffC9AB83), Color(0xffC19865)];
  static List<Color> kGrayGradient = [Color(0xff383838), Color(0xff262626)];
  static List<Color> kBlackGradient = [
    Color(0xff000000).withOpacity(0),
    Color(0xff000000)
  ];
}
