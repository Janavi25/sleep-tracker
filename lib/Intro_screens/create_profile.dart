import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sleep_tracker/controller/constants.dart';
import 'package:sleep_tracker/controller/user.dart';

import '../model/usermodel.dart';

class create_profile extends StatefulWidget {
  // const create_profile({ Key? key }) : super(key: key);

  @override
  State<create_profile> createState() => _create_profileState();
}

class _create_profileState extends State<create_profile> {
  @override
  Widget build(BuildContext context) {
    final uss = UserServices.instance;
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
                            image: NetworkImage(uss.userr.image),
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
            InkWell(
              onTap: () {
                authController.signOut();
              },
              child: Text(
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
            )
          ],
        ),
      ),
    );
  }
}
