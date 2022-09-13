import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sleep_tracker/home/home.dart';
import 'package:intl/intl.dart';
import '../helpers/screen_navigation.dart';

class create_profile extends StatefulWidget {
  // const create_profile({ Key? key }) : super(key: key);

  @override
  State<create_profile> createState() => _create_profileState();
}

class _create_profileState extends State<create_profile> {
  var selectedDate;
  TextEditingController dobController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Container(
          margin: const EdgeInsets.only(
            top: 6,
            bottom: 6,
            left: 16,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 2,
          ),
          child: InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff111422),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 17.sp,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text('Setup Profile',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ),
      ),
      backgroundColor: const Color(0xff0A0C16),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 6.h,
            ),
            Stack(
              children: [
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.only(
                      left: 4,
                      right: 8,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        height: 13.h,
                        width: 13.h,
                        imageUrl: '',
                        placeholder: (context, url) => Shimmer.fromColors(
                            child: Container(),
                            baseColor: Colors.grey,
                            highlightColor: Colors.white),
                        errorWidget: (context, url, error) => Container(
                          padding: const EdgeInsets.all(37),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff111422),
                          ),
                          child: Image(
                            image: const AssetImage('assets/avatar.png'),
                            height: 2.h,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 17.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 85, 62, 199),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xff0A0C16),
                        width: 2.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.camera_enhance_rounded,
                        size: 17.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              'upload an image',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: const Color.fromARGB(255, 85, 62, 199),
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: const BoxDecoration(
                color: Color(0xff111422),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Full name',
                  labelStyle: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                  ),
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: const BoxDecoration(
                color: Color(0xff111422),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Gender',
                  labelStyle: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                  ),
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.female,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                ).then((pickedDate) {
                  if (pickedDate == null) {
                    return;
                  }
                  setState(() {
                    selectedDate = pickedDate;
                  });
                });
              },
              child: Container(
                  height: 6.h,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xff111422),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 19.sp,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      selectedDate == null
                          ? Text(
                              'Date of birth',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                            )
                          : Text(
                              DateFormat.yMMMd().format(selectedDate),
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                            ),
                    ],
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (() {
          changeScreen(context, home());
        }),
        child: Container(
          height: 5.5.h,
          width: 100.w,
          margin: EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 5.h,
            top: 20,
          ),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 85, 62, 199),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  // offset: Offset(0.5, 1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  color: Color.fromARGB(255, 15, 19, 35),
                )
              ]),
          child: Center(
            child: Text(
              'Continue',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
