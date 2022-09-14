import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
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
                      child: Image.asset(
                        "assets/2.png",
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
                  height: 4.h,
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
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    '${uss.userr.name}',
                    style: TextStyle(
                      color: greetings(DateTime.now()) == "Good Night"
                          ? Colors.white
                          : greetings(DateTime.now()) == "Good Evening"
                              ? Colors.black
                              : Colors.black,
                      fontSize: 20.sp,
                    ),
                  ),
                )
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
