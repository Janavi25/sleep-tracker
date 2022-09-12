import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleep_tracker/controller/constants.dart';

import '../model/usermodel.dart';

class UserServices extends GetxController {
  static UserServices instance = Get.find();
  String collection = "users";

  UserModel? userr;
  String UID = "";
  String phone = "";
  bool loading = false;

  late Stream userstream;
  UserModel get user => userr!;
  UserServices() {
    getUser();
    getUser1();
    update();
    // getpincode();
  }

  Future<void> getUser() async {
    final User currentUser = auth.currentUser!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("loggedIn") ?? false) {
      UID = currentUser.uid;
      userr = await getUserById(UID);
      update();
      // notifyListeners();
    }
  }

  Future<void> getUser1() async {
    final User currentUser = auth.currentUser!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("loggedIn") ?? false) {
      UID = currentUser.uid;
      userstream = firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .snapshots();
      userstream.listen((event) {
        userr = UserModel.fromSnapshot(event);
        update();
      });
    }
  }

  void addToadbook(Map cartItem) async {
    final User currentUser = auth.currentUser!;
    UID = currentUser.uid;
    await firebaseFirestore.collection(collection).doc(UID).update({
      "adbook": FieldValue.arrayUnion([cartItem]),
    });
    // analytics.logEvent(name: 'add adbook', parameters: {
    //   "latitude": cartItem['latitude'],
    //   "longitude": cartItem['longitude']
    // });
    // userr = await getUserById(UID);
    // notifyListeners();
  }

  void updateUser(Map<String, dynamic> values) async {
    loading = true;
    update();
    // final User currentUser = await _auth.currentUser();
    final User currentUser = auth.currentUser!;
    UID = currentUser.uid;
    firebaseFirestore.collection(collection).doc(UID).update(values);
    // checkupdateuser(UID);
    // userr = await getUserById(UID);
    loading = false;
    update();
  }

  void removeadbook(Map cartItem) async {
    final User currentUser = auth.currentUser!;
    UID = currentUser.uid;
    firebaseFirestore.collection(collection).doc(UID).update({
      "adbook": FieldValue.arrayRemove([cartItem]),
    });

    // userr = await getUserById(UID);
    update();
  }

  Future<UserModel> getUserById(String id) async =>
      await firebaseFirestore.collection(collection).doc(id).get().then((doc) {
        if (!doc.exists) {
          return null!;
        } else {
          return UserModel.fromSnapshot(doc);
        }
      });
}
