import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sleep_tracker/Authentication/Onboarding/intro_screens.dart';
import 'package:sleep_tracker/Authentication/login_signup.dart';
import 'package:sleep_tracker/Authentication/splash/splash.dart';

import 'controller/appprovider.dart';
import 'controller/authcontroller.dart';
import 'controller/constants.dart';
import 'controller/user.dart';
import 'home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AuthProviderl.initialize()),
      ChangeNotifierProvider.value(value: UserServices()),
      ChangeNotifierProvider.value(value: AppProvider()),
    ],
    child: Phoenix(child: MyApp()),
  ));
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
            return ScreensController();
          },
        ));
  }
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final auth = Provider.of<AuthProviderl>(context);
    final _appProviderInst = Provider.of<AppProvider>(context);

    print(auth.status);
    switch (auth.status) {
      case Status.Uninitialized:
        return splash();
      case Status.Unauthenticated:
        return splash();
      // case Status.Authenticating:
      //   return AuthPage();
      case Status.Authenticated:
        return home();
      default:
        return splash();
    }
  }
}
