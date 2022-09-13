import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sleep_tracker/Intro_screens/create_profile.dart';
import 'package:sleep_tracker/helpers/screen_navigation.dart';
import 'package:sleep_tracker/home/home.dart';

class login_signup extends StatefulWidget {
  // const login_signup({ Key? key }) : super(key: key);

  @override
  State<login_signup> createState() => _login_signupState();
}

class _login_signupState extends State<login_signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0C16),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 72.h,
              decoration: BoxDecoration(
                color: const Color(0xff111422),
                image: DecorationImage(
                  image: const AssetImage(
                    'assets/stars.png',
                  ),
                  colorFilter: ColorFilter.mode(
                    const Color(0xff111422).withOpacity(0.3),
                    BlendMode.dstATop,
                  ),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0)),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('assets/logo.png'),
                      height: 12.h,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Hello, Sleep!',
                      style: GoogleFonts.trirong(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  RichText(
                    softWrap: true,
                    text: TextSpan(
                      text: 'Welcome to',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.5,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Hello, Sleep!',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: const Color.fromARGB(255, 85, 62, 199),
                              letterSpacing: 0.5,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      'login or create an account to track and analyse your sleep pattern',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      changeScreen(context, create_profile());
                    }),
                    child: Container(
                      height: 6.5.h,
                      width: 100.w,
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 20,
                      ),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 85, 62, 199),
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          boxShadow: [
                            BoxShadow(
                              // offset: Offset(0.5, 1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              color: Color.fromARGB(255, 15, 19, 35),
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Image(
                            image: const AssetImage('assets/google.png'),
                            height: 3.h,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            'Continue with Google',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
