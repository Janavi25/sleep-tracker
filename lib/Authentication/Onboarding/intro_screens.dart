import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sleep_tracker/Authentication/login_signup.dart';
import 'package:sleep_tracker/helpers/screen_navigation.dart';

class Intro_Screens extends StatefulWidget {
  // const Intro_Screens({ Key? key }) : super(key: key);

  @override
  State<Intro_Screens> createState() => _Intro_ScreensState();
}

class _Intro_ScreensState extends State<Intro_Screens> {
  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titlePadding: EdgeInsets.all(0),
      contentMargin: EdgeInsets.only(top: 50),
      pageColor: Color(0xff0A0C16),
      imageAlignment: Alignment.bottomCenter,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      body: IntroductionScreen(
        key: GlobalKey<IntroductionScreenState>(),
        globalBackgroundColor: Color(0xff0A0C16),
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: InkWell(
              onTap: () {
                changeScreenReplacement(context, login_signup());
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: const Text(
                  'skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
        pages: [
          PageViewModel(
            titleWidget: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 5,
              ),
              child: Text(
                'Easily track and analyse your sleep pattern',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  height: 1.4,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            bodyWidget: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 8,
              ),
              child: Text(
                'Review statistics that may reveal a checking truth about your health',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  height: 1.4,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            image: Container(
              // margin: const EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/intro_sleep.png',
                width: 250,
                alignment: Alignment.center,
              ),
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            titleWidget: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 60,
                vertical: 5,
              ),
              child: Text(
                'Vivid and detailed sleep report analysis',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  height: 1.4,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            bodyWidget: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 8,
              ),
              child: Text(
                'show your sleep time, wakeup time and how to improve your sleep',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  height: 1.4,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            image: Container(
              // margin: const EdgeInsets.only(bottom: 5, top: 100),
              child: Image.asset(
                'assets/intro_sleep1.png',
                width: 300,
                height: 250,
                alignment: Alignment.center,
              ),
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            titleWidget: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 5,
              ),
              child: Text(
                'Have pleasent mornings with smart alarm',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  height: 1.4,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            bodyWidget: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 8,
              ),
              child: Text(
                'Wakes you up gently with gentle sound in optimal moment for pleasent morning',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  height: 1.4,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            image: Container(
              // margin: const EdgeInsets.only(bottom: 5, top: 100),
              child: Image.asset(
                'assets/intro_sleep2.png',
                width: 250,
                alignment: Alignment.center,
              ),
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () {
          changeScreenReplacement(context, login_signup());
        },
        showSkipButton: false,
        skipOrBackFlex: 0,
        nextFlex: 0,
        back: const Icon(Icons.arrow_back),
        next: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color(0xFF3CDAF7),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 15,
          ),
        ),
        done: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color(0xFF3CDAF7),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 15,
          ),
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: const EdgeInsets.all(12.0),
        dotsDecorator: const DotsDecorator(
          activeColor: Color(0xFF3CDAF7),
          size: Size(5.0, 5.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(10.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
