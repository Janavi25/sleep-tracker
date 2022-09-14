import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_tracker/controller/authcontroller.dart';
import 'package:sleep_tracker/helpers/screen_navigation.dart';
import 'package:sleep_tracker/main.dart';

class home extends StatefulWidget {
  // const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProviderl>(context);
    return Scaffold(
      backgroundColor: const Color(0xff0A0C16),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _auth.signOut();
                nohistorychangescreen(context, ScreensController());
              },
              child: Text(
                "HOME",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
