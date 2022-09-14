import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:platform_device_id/platform_device_id.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sleep_tracker/Authentication/splash/splash.dart';
import 'package:sleep_tracker/Intro_screens/create_profile.dart';
import 'package:sleep_tracker/controller/user.dart';
import 'package:sleep_tracker/home/home.dart';

import '../helpers/screen_navigation.dart';
import '../model/usermodel.dart';
import 'appprovider.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Business,
  Anonymous
}

class AuthProviderl with ChangeNotifier {
  static const LOGGED_IN = "loggedIn";
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  String currentDevice;
  Status _status = Status.Uninitialized;
  bool dev = true;
  UserServices _userServicse = UserServices();

  UserModel _userModel;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  TextEditingController phoneNo;
  String smsOTP;

  String verificationId;
  String errorMessage = '';
  bool loggedIn;
  bool anony;

  bool loading = false;
  bool copopen = false;
  bool otpSent = false;
  bool shopreg = false;
  String mode;
//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  // Function get getauser => _getusera;
  User get user => _user;

  // String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
  //     length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Random _rnd = Random();
  AuthProviderl.initialize() {
    readPrefs();
  }
  Future<void> changeStatus() async {
    _status = Status.Authenticated;
    notifyListeners();
    _user = _auth.currentUser;
    _userModel = await _userServicse.getUserById(_user.uid);
    _userServicse.getUser();
    _userServicse.getUser1();
    notifyListeners();
    return;
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    final Directory libCacheDir =
        new Directory("${cacheDir.path}/libCachedImageData");
    await libCacheDir.delete(recursive: true);
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();
    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

//  AppProvider _appProvider = AppProvider();
  Future<void> readPrefs() async {
    await Future.delayed(Duration(seconds: 0)).then((v) async {
//      _appProvider.getproduct;
      analytics.logAppOpen();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      loggedIn = prefs.getBool(LOGGED_IN) ?? false;
      anony = prefs.getBool('Anonymous') ?? false;
      shopreg = prefs.getBool('shopreg') ?? false;
      mode = prefs.getString('mode') ?? '';
      // guest= prefs.getBool(GUEST_IN) ?? false;
      if (loggedIn) {
        if (mode == 'business') {
          // analytics.setUserProperty(name: 'type', value: 'phone');
          // analytics.setUserProperty(name: 'uid', value: _auth.currentUser.uid);
          _user = _auth.currentUser;
          _userModel = await _userServicse.getUserById(_user.uid);
          _status = Status.Business;
          analytics.setUserId(id: _user.uid);
          notifyListeners();
          return;
        } else {
          analytics.setUserProperty(name: 'type', value: 'phone');
          analytics.setUserProperty(name: 'uid', value: _auth.currentUser.uid);
          _user = _auth.currentUser;
          _userModel = await _userServicse.getUserById(_user.uid);
          _status = Status.Authenticated;
          analytics.setUserId(id: _user.uid);
          notifyListeners();
          return;
        }
      } else if (anony) {
        analytics.setUserProperty(name: 'type', value: 'anonymous');
        analytics.setUserProperty(name: 'uid', value: _auth.currentUser.uid);
        _user = _auth.currentUser;

        _status = Status.Anonymous;
        notifyListeners();
        return;
      }

      _status = Status.Unauthenticated;
      notifyListeners();
    });
  }

  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
    loading = true;
    notifyListeners();
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      // build(context);
      loading = false;
      notifyListeners();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (c) {
            return Dialog(
              child: SizedBox(
                width: Adaptive.w(100),
                height: Adaptive.h(41),
                child: Container(),
              ),
            );
          });
      // changeScreen(context, );
      copopen = true;
//      smsOTPDialog(context).then((value) {
//        print('sign in');
//      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91' + number.trim(), // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            // this.verificationId = verId;
            if (!copopen) {
              this.verificationId = verId;
              loading = false;
              notifyListeners();
              // changeScreen(context, ConfirmOtpPage(number));
            }
          },
          codeSent:
              //changeScreen(context, ConfirmOtpPage()),
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential.toString() + "lets make this work");
            if (_auth.currentUser != null && _userModel != null) {
              // User olduser = _auth.currentUser;
              debugPrint('old');
              onldsignIn(context /*, olduser*/);
              // signIn(context, cred: phoneAuthCredential, auto: true);
            } else {
              signIn(context, cred: phoneAuthCredential, auto: true);
            }
            analytics
                .logEvent(name: 'verification', parameters: {'auto': true});
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            handleError(exceptio, context);
            // print('${exceptio.message} + something is wrong');
            // Fluttertoast.showToast(msg: exceptio.message.toString(), backgroundColor: Colors.grey, textColor: Colors.black);
          });
    } catch (e) {
      loading = false;
      handleError(e, context);
      notifyListeners();
    }
  }

  Future<void> verifyPhoneNumber2(BuildContext context, String number) async {
    loading = true;
    notifyListeners();
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      // build(context);
      loading = false;
      notifyListeners();
      // changeScreenReplacement(context, Verification(number));
      copopen = true;
//      smsOTPDialog(context).then((value) {
//        print('sign in');
//      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91' + number.trim(), // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            // this.verificationId = verId;
            if (!copopen) {
              this.verificationId = verId;
              loading = false;
              notifyListeners();
              // changeScreen(context, Verification(number));
            }
          },
          codeSent:
              //changeScreen(context, ConfirmOtpPage()),
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            changeNumber(context, cred: phoneAuthCredential, auto: true);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            handleError(exceptio, context);
            // print('${exceptio.message} + something is wrong');
            // Fluttertoast.showToast(msg: exceptio.message.toString(), backgroundColor: Colors.grey, textColor: Colors.black);
          });
    } catch (e) {
      loading = false;
      handleError(e, context);
      notifyListeners();
    }
  }

  Future<void> getotp2(BuildContext context, String otp) async {
    smsOTP = otp;
    loading = true;
    notifyListeners();
    changeNumber(context);
  }

  changeNumber(BuildContext context,
      {PhoneAuthCredential cred, bool auto}) async {
    try {
      if (auto != true) {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsOTP,
        );
        await _auth.currentUser.updatePhoneNumber(credential);
      } else {
        await _auth.currentUser.updatePhoneNumber(cred);
      }
      _userServicse.updateUser({'number': _auth.currentUser.phoneNumber});
      _userServicse.getUser();
      loading = false;
      Fluttertoast.showToast(
          msg: 'Please wait verifying...',
          backgroundColor: Colors.grey,
          textColor: Colors.black);
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (context) => MyProfile()), (_) => false);
      notifyListeners();
    } catch (e) {
      handleError(e, context);
      loading = false;
      print("${e.toString()}");
    }
  }

  // Future<String> referrallink(String code) async {
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //     uriPrefix: dev
  //         ? 'https://goeleventhmile.page.link'
  //         : 'https://goeleventhmile.com/link',
  //     link: Uri.parse('https://com.goeleventhmile/referalcode?id=$code'),
  //     androidParameters: AndroidParameters(
  //       packageName: 'com.goeleventhmile',
  //       fallbackUrl: Uri.parse(
  //           'https://play.google.com/store/apps/details?id=com.goeleventhmile'),
  //     ),
  //     iosParameters: IOSParameters(
  //       bundleId: 'com.goeleventhmile',
  //       minimumVersion: '0.0.6',
  //       appStoreId: '123456789',
  //       fallbackUrl: Uri.parse(
  //           'https://play.google.com/store/apps/details?id=com.goeleventhmile'),
  //     ),
  //     googleAnalyticsParameters: GoogleAnalyticsParameters(
  //       campaign: 'referral',
  //       medium: 'share',
  //       source: 'Go Extra Mile',
  //       content: 'code',
  //       term: '',
  //     ),
  //     navigationInfoParameters: NavigationInfoParameters(
  //       forcedRedirectEnabled: false,
  //     ),
  //   );

  //   final ShortDynamicLink shortLink =
  //       await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  //   final Uri shortUrl = shortLink.shortUrl;
  //   return shortUrl.toString();
  // }

  handleError(error, BuildContext context) {
    loading = false;
    notifyListeners();
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        print("The verification code is invalid");
        Fluttertoast.showToast(
            msg: 'Invalid OTP',
            backgroundColor: Colors.grey,
            textColor: Colors.black);
        break;
      case 'invalid-verification-code':
        Fluttertoast.showToast(
            msg: 'Invalid OTP',
            backgroundColor: Colors.grey,
            textColor: Colors.black);
        break;
      case 'invalid-phone-number':
        Fluttertoast.showToast(
            msg: 'Invalid Phone Number',
            backgroundColor: Colors.grey,
            textColor: Colors.black);
        break;
      case 'network-request-failed':
        Fluttertoast.showToast(
            msg: 'No Internet Connection',
            backgroundColor: Colors.grey,
            textColor: Colors.black);

        break;
      case 'credential-already-in-use':
        Fluttertoast.showToast(
            msg:
                'This mobile number is already in use try using another number to log in',
            backgroundColor: Colors.grey,
            textColor: Colors.black);

        break;
      case 'status':
        signIn(context);
        // Fluttertoast.showToast(
        //     msg:
        //         'This mobile number is already in use try using another number to log in',
        //     backgroundColor: Colors.grey,
        //     textColor: Colors.black);

        break;
      default:
        print(error.code);
        Fluttertoast.showToast(
            msg: error.code,
            backgroundColor: Colors.grey,
            textColor: Colors.black);
        break;
    }
  }

  void _createnewUser(
      {String id,
      String number,
      String email,
      List fav,
      List cart,
      List favshop}) async {
    Future<void> initPlatformState() async {
      String deviceId;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        deviceId = await PlatformDeviceId.getDeviceId;
      } on PlatformException {
        deviceId = 'Failed to get deviceId.';
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.

      currentDevice = deviceId;
    }

    initPlatformState();
    _userServicse.createUser({
      "id": id,
      "number": number ?? '',
      "name": '',
      "age": 0,
      "address": '',
      "deviceid": currentDevice,
      "adbook": [],
      "image": "",
      "email": email ?? '',
      "sharelink": "",
      "cart": cart,
      "favourite": fav,
      "code": "",
      "ridername": "",
      "favshop": favshop,

      "order": [],
      // "activeorder": [],
      "wallet": 0,
      // "passbook": [],
      "purchase": 0,

      // "notification": [],
    });
  }

  void _createUser(
      {String id,
      String number,
      String email,
      /*String name, String email, String image*/ bool userreg}) async {
    Future<void> initPlatformState() async {
      String deviceId;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        deviceId = await PlatformDeviceId.getDeviceId;
      } on PlatformException {
        deviceId = 'Failed to get deviceId.';
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.

      currentDevice = deviceId;
    }

    initPlatformState();
    userreg
        ? _userServicse.createUser({
            "id": id,
            "number": number ?? '',
            "name": /*name??'',*/ '',
            "age": 0,
            "address": '',
            "adbook": [],
            "image": /*image??*/ '',
            "email": email ?? '',
            "cart": [],
            "favourite": [],
            "favshop": [],
            "deviceid": currentDevice,
            "order": [],
            "wallet": 0,
            "purchase": 0,
            "code": "",
            "ridername": "",
            "sharelink": "",
            // "notification": [],
          })
        : null;
  }

  signinFLOW(BuildContext context) async {
    Future.delayed(Duration(seconds: 2));
    if (_userModel.gender.isEmpty) {
// Here you can write your code
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => create_profile()),
          (_) => false);
    } else {
      final _firestore = FirebaseFirestore.instance;
      await _firestore
          .collection('users')
          .doc(_auth.currentUser.uid)
          .collection('offlinerides')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          element.reference.delete();
        });
      });
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => home()), (_) => false);
    }
  }

  signIn(BuildContext context, {PhoneAuthCredential cred, bool auto}) async {
    try {
      loading = true;
      UserCredential user;
      bool a = await GoogleSignIn().isSignedIn();

      print(a.toString());
      while (a) {
        await GoogleSignIn().disconnect();
      }

      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      user = await FirebaseAuth.instance.signInWithCredential(credential);

      final User currentUser = _auth.currentUser;
      assert(user.user.uid == currentUser.uid);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(LOGGED_IN, true);
      loggedIn = true;
      if (user != null) {
        _userModel = await _userServicse.getUserById(user.user.uid);
        if (_userModel == null) {
          analytics.logSignUp(signUpMethod: 'google');
          _createUser(
              id: user.user.uid,
              email: user.user.email,
              userreg: true,
              number: "");
        }
      }

      bool check = true;
      while (check) {
        if (userModel != null) {
          check = false;
        } else {
          _userModel = await _userServicse.getUserById(user.user.uid);
        }
      }
      await _userServicse.getUser();

      analytics.logLogin(loginMethod: 'phone');
      loading = false;
      Fluttertoast.showToast(
          msg: 'Please wait verifying...',
          backgroundColor: Colors.grey,
          textColor: Colors.black);
      _status = Status.Authenticated;

      _userServicse.getUser1();
      Future<void> initPlatformState() async {
        String deviceId;
        // Platform messages may fail, so we use a try/catch PlatformException.
        try {
          deviceId = await PlatformDeviceId.getDeviceId;
        } on PlatformException {
          deviceId = 'Failed to get deviceId.';
        }

        // If the widget was removed from the tree while the asynchronous platform
        // message was in flight, we want to discard the reply rather than calling
        // setState to update our non-existent appearance.

        currentDevice = deviceId;
      }

      initPlatformState();
      await multipleDeviceCheck(context);

      notifyListeners();
    } catch (e) {
      handleError(e, context);
      // Fluttertoast.showToast(msg: 'Error, Please check Yor Internet', backgroundColor: Colors.grey, textColor: Colors.black);
      loading = false;
      print("${e.toString()}");
    }
  }

  onldsignIn(BuildContext context /*, User olduser*/,
      {GoogleAuthCredential cred, bool auto}) async {
    try {
      // final AuthCredential credential = PhoneAuthProvider.credential(
      //   verificationId: verificationId,
      //   smsCode: smsOTP,
      // );
      loading = true;
      // _userModel = await _guestService.getGuestById(_auth.currentUser.uid);
      notifyListeners();
      // UserCredential user;
      bool a = await GoogleSignIn().isSignedIn();
      print(a.toString());
      while (a) {
        await GoogleSignIn().disconnect();
      }

      await _auth.currentUser.delete();
      // final UserCredential user = await _auth.signInWithCredential(credential);
      // if (auto != true) {
      //   final AuthCredential credential = PhoneAuthProvider.credential(
      //     verificationId: verificationId,
      //     smsCode: smsOTP,
      //   );
      //   user = await _auth.signInWithCredential(credential);
      // } else {
      //   user = await _auth.signInWithCredential(cred);
      // }
      UserCredential user;
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      user = await FirebaseAuth.instance.signInWithCredential(credential);
      final User currentUser = _auth.currentUser;
      assert(user.user.uid == currentUser.uid);
      print(user.user.uid);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(LOGGED_IN, true);
      prefs.setBool('Anonymous', false);
      loggedIn = true;
      if (user != null) {
        UserModel newuser;
        newuser = await _userServicse.getUserById(user.user.uid);
        if (newuser == null) {
          print('new');
          analytics.logSignUp(signUpMethod: 'AnonymoustoPhone');
          _createnewUser(
            id: user.user.uid,
            email: user.user.email,
            number: "",
          );
        } else {}
        _user = _auth.currentUser;
        notifyListeners();
        analytics.logLogin(loginMethod: 'AnonymoustoPhone');

        _userModel = await _userServicse.getUserById(user.user.uid);
        await _userServicse.getUser();
        _userServicse.getUser1();
        // _userServicse.checkupdateuser(user.user.uid);
        loading = false;
        Fluttertoast.showToast(
            msg: 'Please wait verifying...',
            backgroundColor: Colors.grey,
            textColor: Colors.black);
        // await _userServicse.updateUser({"deviceid": currentDevice});
//         if (userModel.ridername.isEmpty || userModel.email.isEmpty) {
//           Future.delayed(const Duration(milliseconds: 3000), () {
// // Here you can write your code
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => EditProfileNew(
//                         Provider.of<UserServices>(context).user)),
//                 (_) => false);
//           });
//         } else {
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => MainTab(
//                         index: 0,
//                       )),
//               (_) => false);
//         }
        Future<void> initPlatformState() async {
          String deviceId;
          // Platform messages may fail, so we use a try/catch PlatformException.
          try {
            deviceId = await PlatformDeviceId.getDeviceId;
          } on PlatformException {
            deviceId = 'Failed to get deviceId.';
          }

          // If the widget was removed from the tree while the asynchronous platform
          // message was in flight, we want to discard the reply rather than calling
          // setState to update our non-existent appearance.

          currentDevice = deviceId;
        }

        initPlatformState();
        await multipleDeviceCheck(context);

        loading = false;

        _status = Status.Authenticated;
        notifyListeners();
      }
    } catch (e) {
      loading = false;
      handleError(e, context);
      // Fluttertoast.showToast(msg: 'Error, Please check Yor Internet', backgroundColor: Colors.grey, textColor: Colors.black);
      print("${e.toString()}");
    }
  }

  // Future<void> getotp2(BuildContext context, String otp) async{
  //   smsOTP = otp;
  //   loading = true;
  //   notifyListeners();
  //   if (_auth.currentUser != null&& _userModel !=null) {
  //       final AuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId,
  //         smsCode: smsOTP,
  //       );
  //     // _user.updatePhoneNumber(credential);
  //       _user.linkWithCredential(credential);
  //     print(user.phoneNumber);
  //     _userServicse.updateUser({'number':user.phoneNumber});
  //   } else {
  //     signIn(context);
  //   }
  // }
  Future<void> multipleDeviceCheck(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) async {
      if (value.data()['deviceid'] == null) {
        _userServicse.updateUser({"deviceid": currentDevice});
        signinFLOW(context);
      } else {
        if (value.data()['deviceid'] == currentDevice) {
          signinFLOW(context);
        } else {
          await showDialog(
              barrierColor: Colors.black87,
              barrierDismissible: false,
              context: context,
              builder: (ctxt) => new AlertDialog(
                    content: Container(
                      height: Adaptive.h(40),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/androidPhone.png",
                            ),
                            Text(
                              "Multiple device Login detected. For security reasons your previous sessions in other devices will be Logged out.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15.sp),
                            ),

                            // InkWell(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Text(
                            //       "Log out & Continue",
                            //       style: TextStyle(fontSize: 17.sp),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .85,
                              height: Adaptive.h(5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: Colors.black,
                                child: Center(
                                  child: TextButton(
                                    onPressed: () async {
                                      await _userServicse.updateUser(
                                          {"deviceid": currentDevice});
                                      signinFLOW(
                                        context,
                                      );
                                    },
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: InkWell(
                                  onTap: () async {
                                    signOut();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => splash()),
                                        (_) => false);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                            ),
                          ]),
                    ),
                    // actions: [
                    //   Center(
                    //     child: InkWell(
                    //         onTap: () async {
                    //           Provider.of<AuthProviderl>(context, listen: false)
                    //               .signOut();
                    //           Navigator.pushAndRemoveUntil(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) => IntroPage()),
                    //               (_) => false);
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(bottom: 5.0),
                    //           child: Text(
                    //             "Cancel",
                    //             style: TextStyle(
                    //               fontSize: 15.sp,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //         )),
                    //   ),

                    // InkWell(
                    //   onTap: () async {
                    //     await _userServicse
                    //         .updateUser({"deviceid": currentDevice});
                    //     signinFLOW(context);
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Text(
                    //       " Ok ",
                    //       style: TextStyle(fontSize: 17.sp),
                    //     ),
                    //   ),
                    // ),
                    // ],
                  ));
        }
      }
    });
  }

  Future<void> getotp(BuildContext context, String otp, String number) async {
    UserCredential user;
    bool auto;
    smsOTP = otp;
    loading = true;
    notifyListeners();
    if (_auth.currentUser != null && _userModel != null) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsOTP,
        );
        await _auth.currentUser.linkWithCredential(credential).then((value) {
          _userServicse.updateUser({"number": "+91" + number});
          Navigator.of(context).pop();
          loading = false;
        });
      } catch (e) {
        // print(e.code);
        // Fluttertoast.showToast(
        //     msg: e.code, backgroundColor: Colors.grey, textColor: Colors.black);
        // Navigator.of(context).pop();
        // loading = false;
        handleError(e, context);
      }
      debugPrint('old');
      // User olduser = _auth.currentUser;

      // Navigator.of(context).pop();

      // signIn(context);
    } else {
      // if (auto != true) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsOTP,
        );
        await _auth.currentUser.linkWithCredential(credential).then((value) {
          _userServicse.updateUser({"number": "+91" + number});
          Navigator.of(context).pop();
        });
      } catch (e) {
        handleError(e, context);
      }
    }
  }

  Future signOut({BuildContext context}) async {
    nohistorychangescreen(context, splash());
    _auth.signOut();

    _status = Status.Unauthenticated;
    // notifyListeners();
    // _deleteCacheDir();
    _deleteAppDir();

    // userModel.ridername == null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Phoenix.rebirth(context);
    Provider.of<UserServices>(context, listen: false).clear();
    Provider.of<AppProvider>(context, listen: false).clear();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future signInAnonymously(BuildContext context) async {
    try {
      loading = true;
      notifyListeners();
      await FirebaseAuth.instance.signInAnonymously().then((value) async {
        final User currentUser = _auth.currentUser;
        assert(value.user.uid == currentUser.uid);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('Anonymous', true);
        if (value != null) {
          // if (_userModel == null) {
          _createUser(id: value.user.uid, number: '00', userreg: false);
          // }
          _status = Status.Anonymous;
          _user = _auth.currentUser;
          notifyListeners();

          loading = false;
          analytics.logLogin(loginMethod: 'anonymous');
          notifyListeners();
        }
      });
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => home()), (_) => false);
    } catch (e) {
      loading = false;
      // Fluttertoast.showToast(msg: 'Error, Please check Yor Internet', backgroundColor: Colors.grey, textColor: Colors.black);
      handleError(e, context);
      print(e); // TODO: show dialog with error
    }
    return Future.delayed(Duration.zero);
  }
}
