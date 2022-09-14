import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sleep_tracker/home/graphs.dart';
import 'package:sleep_tracker/home/home.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class Navigation extends StatefulWidget {
  // const Navigation({ Key? key }) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final Color navigationBarColor = const Color(0xff111422);
  int selectedIndex = 0;
  PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0C16),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          Center(
            child: home(),
          ),
          Center(
            child: DataVisual(),
          ),
          Center(
            child: home(),
          ),
          Center(
            child: home(),
          ),
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        iconSize: 19.sp,
        backgroundColor: navigationBarColor,
        inactiveIconColor: Colors.grey[700],
        waterDropColor: const Color(0xFF3CDAF7),
        bottomPadding: 20,
        onItemSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            filledIcon: FontAwesomeIcons.house,
            outlinedIcon: FontAwesomeIcons.house,
          ),
          BarItem(
              filledIcon: FontAwesomeIcons.chartSimple,
              outlinedIcon: FontAwesomeIcons.chartSimple),
          BarItem(
            filledIcon: FontAwesomeIcons.userLarge,
            outlinedIcon: FontAwesomeIcons.userLarge,
          ),
        ],
      ),
    );
  }
}
