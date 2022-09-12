import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sleep_tracker/Authentication/login_signup.dart';
import 'package:sleep_tracker/Authentication/splash/splash.dart';
import 'package:sleep_tracker/Intro_screens/create_profile.dart';
import 'package:sleep_tracker/controller/constants.dart';
import 'package:sleep_tracker/controller/user.dart';
import 'package:sleep_tracker/home/home.dart';
import 'package:sleep_tracker/model/usermodel.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  UserModel? _usermodel;
  late UserServices _userServices;
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there
    getUserService();
    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => splash());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => create_profile());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => splash());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => create_profile());
    }
  }

  getUserService() async {
    _userServices = await Get.find();
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth.signInWithCredential(credential).then((value) async {
          if (value.additionalUserInfo!.isNewUser == true) {
            Fluttertoast.showToast(msg: "newuser");
            await firebaseFirestore
                .collection("users")
                .doc(value.user!.uid)
                .set({
              "id": value.user!.uid,
              "email": value.user!.email,
              "name": value.user!.displayName,
              "image": value.user!.photoURL,
              "number": "",
              "first_signin": Timestamp.now(),
            }, SetOptions(merge: true));
            if (_usermodel == null) {
              _usermodel = await _userServices.getUserById(value.user!.uid);
            } else {
              _usermodel = await _userServices.getUserById(value.user!.uid);
            }
          } else {
            Fluttertoast.showToast(msg: "old");

            _usermodel = await _userServices.getUserById(value.user!.uid);
          }
        }).catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  void signOut() async {
    await auth.signOut();
  }
}
