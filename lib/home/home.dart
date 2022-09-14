import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sleep_tracker/Intro_screens/create_profile.dart';
import 'package:sleep_tracker/controller/stars.dart';
import 'package:sleep_tracker/controller/user.dart';
import 'package:sleep_tracker/helpers/screen_navigation.dart';

import '../controller/utils.dart';

class home extends StatefulWidget {
  // const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with TickerProviderStateMixin {
  AnimationController animationController;
  var random = Random();
  bool snore = false;
  bool alarm = false;
  bool moon = false;
  Timer _timer;
  @override
  void dispose() {
    _timer.cancel();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          animationController.reverse();
        }
      });
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => setAnimation());

    // TODO: implement initState
    super.initState();
  }

  void setAnimation() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // Timer.periodic(Duration(seconds: 1), (Timer t) => setAnimation());
    final uss = Provider.of<UserServices>(context);
    return Scaffold(
      backgroundColor: greetings(DateTime.now()) == "Good Night"
          ? Color(0xff0A0C16)
          : greetings(DateTime.now()) == "Good Evening"
              ? Color(0xffFFCF91)
              : Color(0xffDDEEEF),
      body: Stack(
        children: [
          greetings(DateTime.now()) == "Good Night"
              ? Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Color(0xff0A0C16),
                    ),
                    ...makeStar(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    SizedBox(
                      height: 100.h,
                      child: const Image(
                        image: AssetImage('assets/2.png'),
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                )
              : SizedBox(
                  height: 100.h,
                  child: greetings(DateTime.now()) == "Good Evening"
                      ? Image.asset(
                          "assets/3.png",
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.blueGrey[50],
                          child: Image.asset(
                            "assets/1.png",
                            fit: BoxFit.cover,
                          ),
                        )),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    "${greetings(DateTime.now())}",
                    style: TextStyle(
                      color: greetings(DateTime.now()) == "Good Night"
                          ? Colors.white
                          : greetings(DateTime.now()) == "Good Evening"
                              ? Colors.black
                              : Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                  child: Text(
                    '${uss.user.name}' + ' 👋',
                    style: TextStyle(
                      color: greetings(DateTime.now()) == "Good Night"
                          ? Colors.white
                          : greetings(DateTime.now()) == "Good Evening"
                              ? Colors.black
                              : Colors.black,
                      fontSize: 20.sp,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xff111422),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                        ),
                        child: Image(
                          image: const AssetImage('assets/sleep.png'),
                          height: 8.h,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        '${DateTime.now().hour}' +
                            ':' +
                            '${DateTime.now().minute}',
                        style: TextStyle(
                          color: greetings(DateTime.now()) == "Good Night"
                              ? Colors.white
                              : greetings(DateTime.now()) == "Good Evening"
                                  ? Colors.black
                                  : Colors.black,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      GlowButton(
                        width: 50.w,
                        height: 6.h,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        color: const Color(0xFF3CDAF7),
                        glowColor: const Color.fromARGB(255, 42, 163, 184),
                        spreadRadius: 0.1,
                        splashColor: const Color(0xFF3CDAF7),
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: const Color(0xff111422),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              elevation: 1,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter
                                            setState /*You can rename this!*/) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Center(
                                        child: Container(
                                          width: 20.w,
                                          height: 0.8.h,
                                          decoration: const BoxDecoration(
                                            color: Color(0xff0A0C16),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Before sleep guidelines',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.5.sp,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.red[400],
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.phone_android_rounded,
                                                  size: 20.sp,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 65.w,
                                                  child: Text(
                                                    'Place your device next to your bed',
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.sp,
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Container(
                                                  width: 65.w,
                                                  child: Text(
                                                    'Place your phone next to your bed for accurate sleep tracking',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.grey[300],
                                                      fontSize: 13.sp,
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.orange[400],
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.power,
                                                  size: 20.sp,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 65.w,
                                                  child: Text(
                                                    'Plug your phone in',
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.sp,
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Container(
                                                  width: 65.w,
                                                  child: Text(
                                                    'Battery level suggested is 60%',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.grey[300],
                                                      fontSize: 13.sp,
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.moon,
                                                  color: Colors.white,
                                                  size: 18.sp,
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Text(
                                                  'Manual Sleep Tracking',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.5.sp,
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            FlutterSwitch(
                                              width: 13.w,
                                              height: 2.5.h,
                                              toggleSize: 45.0,
                                              value: moon,
                                              borderRadius: 30.0,
                                              padding: 0,
                                              activeColor: Color.fromRGBO(
                                                  51, 226, 255, 1),
                                              inactiveColor: Colors.black38,
                                              onToggle: (val) {
                                                setState(() {
                                                  moon = val;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.clock,
                                                  color: Colors.white,
                                                  size: 18.sp,
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Text(
                                                  'Alarm',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.5.sp,
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            FlutterSwitch(
                                              width: 13.w,
                                              height: 2.5.h,
                                              toggleSize: 45.0,
                                              value: alarm,
                                              borderRadius: 30.0,
                                              padding: 0,
                                              activeColor: Color.fromRGBO(
                                                  51, 226, 255, 1),
                                              inactiveColor: Colors.black38,
                                              onToggle: (val) {
                                                setState(() {
                                                  alarm = val;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.waveSquare,
                                                  color: Colors.white,
                                                  size: 18.sp,
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Text(
                                                  'Snore detection',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.5.sp,
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            FlutterSwitch(
                                              width: 13.w,
                                              height: 2.5.h,
                                              toggleSize: 45.0,
                                              value: snore,
                                              borderRadius: 30.0,
                                              padding: 0,
                                              activeColor: Color.fromRGBO(
                                                  51, 226, 255, 1),
                                              inactiveColor: Colors.black38,
                                              onToggle: (val) {
                                                setState(() {
                                                  snore = val;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              customBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 6.h,
                                                width: 38.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey[500],
                                                    width: 0.1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      15,
                                                    ),
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.5.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )),
                                              ),
                                            ),
                                            Container(
                                              height: 6.h,
                                              width: 38.w,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF3CDAF7),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                    15,
                                                  ),
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Next',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.5.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ],
                                  );
                                });
                              });
                        },
                        child: Center(
                          child: Container(
                            // height: 6.h,
                            // width: 55.w,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(50),
                            //     color: const Color(0xFF3CDAF7),
                            //     boxShadow: const [
                            //       BoxShadow(
                            //         color: Color(0xFF3CDAF7),
                            //         spreadRadius: 0.1,
                            //         blurRadius: 0.1,
                            //       )
                            //     ]),
                            child: Center(
                              child: Text(
                                'Start Sleep',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> makeStar(double width, double height) {
    double starsInRow = width / 50;
    double starsInColumn = height / 50;
    double starsNum = starsInRow != 0
        ? starsInRow * (starsInColumn != 0 ? starsInColumn : starsInRow)
        : starsInColumn;

    List<Widget> stars = [];

    for (int i = 0; i < starsNum; i++) {
      stars.add(Star(
        top: random.nextInt(height.floor()).toDouble(),
        right: random.nextInt(width.floor()).toDouble(),
        animationController: animationController,
      ));
    }

    return stars;
  }
}
