import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sleep_tracker/Authentication/Onboarding/intro_screens.dart';
import 'package:sleep_tracker/Authentication/login_signup.dart';
import 'package:sleep_tracker/home/home.dart';

import '../../controller/appprovider.dart';
import '../../controller/authcontroller.dart';
import '../../main.dart';

class splash extends StatefulWidget {
  // const splash({ Key? key }) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 800,
      splash: const Image(
        image: AssetImage(
          'assets/logo.png',
        ),
        height: 200,
      ),
      nextScreen: Intro_Screens(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: const Color(0xff0A0C16),
    );
  }
}
