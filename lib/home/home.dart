import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sleep_tracker/Intro_screens/create_profile.dart';
import 'package:sleep_tracker/controller/user.dart';
import 'package:sleep_tracker/helpers/screen_navigation.dart';

import '../controller/utils.dart';

class home extends StatefulWidget {
  // const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    final uss = Provider.of<UserServices>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff0A0C16),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  "${greetings(DateTime.now())}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  '${uss.user.name}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
