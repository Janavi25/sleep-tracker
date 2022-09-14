import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sleep_tracker/Navigation/Navigation.dart';
import 'package:sleep_tracker/home/home.dart';
import 'package:intl/intl.dart' as intl;
import '../controller/user.dart';
import '../helpers/screen_navigation.dart';
import 'package:sleep_tracker/controller/constants.dart';

import 'package:sleep_tracker/helpers/screen_navigation.dart';
import 'package:sleep_tracker/home/home.dart';

class create_profile extends StatefulWidget {
  // const create_profile({ Key? key }) : super(key: key);

  @override
  State<create_profile> createState() => _create_profileState();
}

class _create_profileState extends State<create_profile> {
  var selectedDate;
  UserServices _userService = UserServices();
  TextEditingController name = TextEditingController();

  TextEditingController gender = TextEditingController();
  ClockTimeFormat _clockTimeFormat = ClockTimeFormat.TWENTYFOURHOURS;
  ClockIncrementTimeFormat _clockIncrementTimeFormat =
      ClockIncrementTimeFormat.FIVEMIN;

  PickedTime _inBedTime = PickedTime(h: 0, m: 0);
  PickedTime _outBedTime = PickedTime(h: 8, m: 0);
  PickedTime _intervalBedTime = PickedTime(h: 0, m: 0);
  bool genderdone = false;

  double _sleepGoal = 8.0;
  bool _isSleepGoal = false;
  String imageurl;
  bool loading = false;
  @override
  void initState() {
    setState(() {
      loading = true;
    });
    name.text = auth.currentUser.displayName;
    imageurl = auth.currentUser.displayName;
    _isSleepGoal = (_sleepGoal >= 8.0) ? true : false;
    _intervalBedTime = formatIntervalTime(
      init: _inBedTime,
      end: _outBedTime,
      clockTimeFormat: _clockTimeFormat,
      clockIncrementTimeFormat: _clockIncrementTimeFormat,
    );
    setState(() {
      loading = false;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final uss = Provider.of<UserServices>(context);
    return loading == false
        ? Scaffold(
            backgroundColor: const Color(0xff0A0C16),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: Container(
                margin: const EdgeInsets.only(
                  top: 6,
                  bottom: 6,
                  left: 16,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                ),
                child: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onTap: () {
                    changeScreen(context, Navigation());
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff111422),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 17.sp,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
              centerTitle: true,
              title: Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text('Setup Profile',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ),
            ),
            body: genderdone == false
                ? Column(
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.only(
                                left: 4,
                                right: 8,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  height: 13.h,
                                  width: 13.h,
                                  imageUrl: uss.user.image,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                          child: Container(),
                                          baseColor: Colors.grey,
                                          highlightColor: Colors.white),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    padding: const EdgeInsets.all(37),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff111422),
                                    ),
                                    child: Image(
                                      image: AssetImage("assets/avatar.png"),
                                      height: 2.h,
                                    ),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 17.h,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 85, 62, 199),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xff0A0C16),
                                  width: 2.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  Icons.camera_enhance_rounded,
                                  size: 17.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      InkWell(
                        onTap: () {
                          auth.signOut();
                        },
                        child: Text(
                          'upload an image',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: const Color.fromARGB(255, 85, 62, 199),
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xff111422),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: TextFormField(
                          controller: name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Full name',
                            labelStyle: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                            ),
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xff111422),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: TextFormField(
                          controller: gender,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Gender',
                            labelStyle: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                            ),
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.female,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      InkWell(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          ).then((pickedDate) {
                            if (pickedDate == null) {
                              return;
                            }
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          });
                        },
                        child: Container(
                          height: 6.h,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xff111422),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                size: 19.sp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              selectedDate == null
                                  ? Text(
                                      'Date of birth',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                    )
                                  : Text(
                                      intl.DateFormat.yMMMd()
                                          .format(selectedDate),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      TimePicker(
                        initTime: _inBedTime,
                        endTime: _outBedTime,
                        height: 260.0,
                        width: 260.0,
                        onSelectionChange: _updateLabels,
                        onSelectionEnd: (a, b) => print(
                            'onSelectionEnd => init : ${a.h}:${a.m}, end : ${b.h}:${b.m}'),
                        primarySectors: _clockTimeFormat.value,
                        secondarySectors: _clockTimeFormat.value * 2,
                        decoration: TimePickerDecoration(
                          baseColor: Color(0xFF1F2633),
                          pickerBaseCirclePadding: 15.0,
                          sweepDecoration: TimePickerSweepDecoration(
                            pickerStrokeWidth: 30.0,
                            pickerColor:
                                _isSleepGoal ? Color(0xFF3CDAF7) : Colors.white,
                            showConnector: true,
                          ),
                          initHandlerDecoration: TimePickerHandlerDecoration(
                            color: Color(0xFF141925),
                            shape: BoxShape.circle,
                            radius: 12.0,
                            icon: Icon(
                              Icons.power_settings_new_outlined,
                              size: 20.0,
                              color: Color(0xFF3CDAF7),
                            ),
                          ),
                          endHandlerDecoration: TimePickerHandlerDecoration(
                            color: Color(0xFF141925),
                            shape: BoxShape.circle,
                            radius: 12.0,
                            icon: Icon(
                              Icons.notifications_active_outlined,
                              size: 20.0,
                              color: Color(0xFF3CDAF7),
                            ),
                          ),
                          primarySectorsDecoration: TimePickerSectorDecoration(
                            color: Colors.white,
                            width: 1.0,
                            size: 4.0,
                            radiusPadding: 25.0,
                          ),
                          secondarySectorsDecoration:
                              TimePickerSectorDecoration(
                            color: Color(0xFF3CDAF7),
                            width: 1.0,
                            size: 2.0,
                            radiusPadding: 25.0,
                          ),
                          clockNumberDecoration:
                              TimePickerClockNumberDecoration(
                            defaultTextColor: Colors.white,
                            defaultFontSize: 12.0,
                            scaleFactor: 2.0,
                            showNumberIndicators: true,
                            clockTimeFormat: _clockTimeFormat,
                            clockIncrementTimeFormat: _clockIncrementTimeFormat,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(62.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${intl.NumberFormat('00').format(_intervalBedTime.h)}Hr ${intl.NumberFormat('00').format(_intervalBedTime.m)}Min',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: _isSleepGoal
                                      ? Color(0xFF3CDAF7)
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: 90.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFF1F2633),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _isSleepGoal
                                ? "Sleep Goal Is Optimal 😄"
                                : 'You Need to Sleep More 😴',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _timeWidget(
                              'BedTime',
                              _inBedTime,
                              const Icon(
                                Icons.bed_rounded,
                                size: 25.0,
                                color: Color(0xFF3CDAF7),
                              ),
                            ),
                            _timeWidget(
                              'WakeUp',
                              _outBedTime,
                              Icon(
                                Icons.sunny,
                                size: 25.0,
                                color: Color(0xFF3CDAF7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            bottomNavigationBar: GestureDetector(
              onTap: (() {
                if (genderdone == true) {
                  var clockTimeDivision = getClockTimeFormatDivision(
                    _clockTimeFormat,
                    _clockIncrementTimeFormat,
                  );
                  var _inTime = pickedTimeToDivision(
                    pickedTime: _inBedTime,
                    clockTimeFormat: _clockTimeFormat,
                    clockIncrementTimeFormat: _clockIncrementTimeFormat,
                  );
                  var _outTime = pickedTimeToDivision(
                    pickedTime: _outBedTime,
                    clockTimeFormat: _clockTimeFormat,
                    clockIncrementTimeFormat: _clockIncrementTimeFormat,
                  );

                  var sleepTime = _outTime > _inTime
                      ? _outTime - _inTime
                      : clockTimeDivision - _inTime + _outTime;

                  var timeDivisor = 60 ~/ _clockIncrementTimeFormat.value;
                  var sleepHours = sleepTime ~/ timeDivisor;
                  Map timeOfDayToFirebase(TimeOfDay timeOfDay) {
                    return {'hour': timeOfDay.hour, 'minute': timeOfDay.minute};
                  }

                  print(timeOfDayToFirebase(TimeOfDay(
                      hour: _inBedTime.h.toInt(),
                      minute: _inBedTime.m.toInt())));
                  _userService.updateUser({
                    "sleeptime": timeOfDayToFirebase(TimeOfDay(
                        hour: _inBedTime.h.toInt(),
                        minute: _inBedTime.m.toInt())),
                    "wakeuptime": timeOfDayToFirebase(TimeOfDay(
                        hour: _outBedTime.h.toInt(),
                        minute: _outBedTime.m.toInt())),
                    "sleepgoal": sleepHours,
                  });
                  changeScreen(context, Navigation());
                } else {
                  _userService.updateUser({
                    "dob": selectedDate,
                    "name": name.text,
                    "gender": gender.text,
                  });
                  setState(() {
                    genderdone =
                        uss.user.gender != null || uss.user.gender != "";
                  });
                }
              }),
              child: Container(
                height: 5.5.h,
                width: 100.w,
                margin: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: 5.h,
                  top: 20,
                ),
                decoration: const BoxDecoration(
                    color: Color(0xFF3CDAF7),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        // offset: Offset(0.5, 1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        color: Color.fromARGB(255, 15, 19, 35),
                      )
                    ]),
                child: Center(
                  child: Text(
                    'Continue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : SizedBox();
  }

  Widget _timeWidget(String title, PickedTime time, Icon icon) {
    return Container(
      width: 150.0,
      decoration: BoxDecoration(
        color: Color(0xFF1F2633),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
              '${intl.NumberFormat('00').format(time.h)}:${intl.NumberFormat('00').format(time.m)}',
              style: const TextStyle(
                color: Color(0xFF3CDAF7),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              '$title',
              style: const TextStyle(
                color: Color(0xFF3CDAF7),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            icon,
          ],
        ),
      ),
    );
  }

  void _updateLabels(PickedTime init, PickedTime end) {
    _inBedTime = init;
    _outBedTime = end;
    _intervalBedTime = formatIntervalTime(
      init: _inBedTime,
      end: _outBedTime,
      clockTimeFormat: _clockTimeFormat,
      clockIncrementTimeFormat: _clockIncrementTimeFormat,
    );
    _isSleepGoal = validateSleepGoal(
      inTime: init,
      outTime: end,
      sleepGoal: _sleepGoal,
      clockTimeFormat: _clockTimeFormat,
      clockIncrementTimeFormat: _clockIncrementTimeFormat,
    );
    setState(() {});
  }
}
