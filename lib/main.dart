import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sleep_tracker/Authentication/Onboarding/intro_screens.dart';
import 'package:sleep_tracker/Authentication/login_signup.dart';
import 'package:sleep_tracker/Authentication/splash/splash.dart';

import 'home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
