import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sleep_tracker/Authentication/Onboarding/intro_screens.dart';
import 'package:sleep_tracker/Authentication/login_signup.dart';
import 'package:sleep_tracker/Authentication/splash/splash.dart';

import 'home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return splash();
          },
        ));
  }
}
