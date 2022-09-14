import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/usermodel.dart';

class UserServices with ChangeNotifier {
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel userr;
  Map redeemcoin;
  String UID;
  String phone;

  bool loading = false;
  String Pincode;
  UserModel get user => userr;

  UserServices() {
    getUser();
    getUser1();
    // getpincode();
  }

  Stream userstream;
  Stream redeemcoinsss;
  void getpincode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('place') != null) {
      Pincode = prefs.get('place');
    }
  }

  void UserInfo(Map<String, dynamic> values) async {
    final User currentUser = _auth.currentUser;
    UID = currentUser.uid;
    _firestore.collection(collection).doc(UID).set(values);
  }

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).doc(id).set(values);
    notifyListeners();
  }

  void updateUser(Map<String, dynamic> values) async {
    loading = true;
    notifyListeners();
    // final User currentUser = await _auth.currentUser();
    final User currentUser = _auth.currentUser;
    UID = currentUser.uid;
    _firestore.collection(collection).doc(UID).update(values);
    // checkupdateuser(UID);
    // userr = await getUserById(UID);
    loading = false;
    notifyListeners();
  }

  Future<UserModel> getUserById(String id) async =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        if (!doc.exists) {
          return null;
        } else {
          return UserModel.fromSnapshot(doc);
        }
      });
  // void checkupdateuser(String id)async{
  //   loading = true;
  //   notifyListeners();
  //   // final User currentUser = await _auth.currentUser();
  //   if(_auth.currentUser!=null){//TODO:
  //   // final User currentUser =_auth.currentUser;
  //   // UID = currentUser.uid;
  //   await _firestore.collection(collection).doc(id).collection('userinfo').doc('passbook').get().then((value) async{
  //     if(!value.exists) {
  //       print('update');
  //      await _firestore.collection(collection).doc(id).collection('userinfo').doc(
  //           'notifications').set({
  //         'notifications': []});
  //       await _firestore.collection(collection).doc(id).collection('userinfo').doc(
  //           'passbook').set({
  //         'transaction': []});
  //       await _firestore.collection(collection).doc(id).update({
  //         "notification": [],
  //         "cart": [],
  //         "favourite": [],
  //         "favshop": [],
  //         "adbook": [],
  //         "passbook":[],
  //         "code": "RE"+UID.substring(0,5),
  //       });
  //       // userr = await getUserById(UID);
  //       loading = false;
  //       notifyListeners();
  //     }
  //   });}
  // }
  void clear() {
    userr = null;
  }

  void updateUser2(Map<String, dynamic> values, String id) async {
    loading = true;
    notifyListeners();
    _firestore.collection(collection).doc(id).update(values);
    // checkupdateuser(id);
    loading = false;
    notifyListeners();
  }

  void addTofavshop(String values) async {
    final User currentUser = _auth.currentUser;
    UID = currentUser.uid;

    _firestore.collection(collection).doc(UID).update({
      "favshop": FieldValue.arrayUnion([values])
    });
    notifyListeners();
  }

  void removeFromfavshop(String values) async {
    final User currentUser = _auth.currentUser;
    UID = currentUser.uid;
    _firestore.collection(collection).doc(UID).update({
      "favshop": FieldValue.arrayRemove([values])
    });
    notifyListeners();
  }

  // void removenotify(Map values) async{
  //   final User currentUser =_auth.currentUser;
  //   UID = currentUser.uid;
  //   _firestore.collection(collection).doc(UID).update({
  //     "notification": FieldValue.arrayRemove([values])
  //   });
  //   notifyListeners();
  // }
//   void readnotify(Map values) async{
//     final User currentUser =_auth.currentUser;
//     UID = currentUser.uid;
//     _firestore.collection(collection).doc(UID).update({
//       "notification": FieldValue.arrayRemove([values])
//     });
// //    user = await getUserById(UID);
//     notifyListeners();
//   }

  Future<void> getUser1() async {
    final User currentUser = _auth.currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("loggedIn") ?? false) {
      UID = currentUser.uid;
      userstream =
          _firestore.collection('users').doc(_auth.currentUser.uid).snapshots();
      userstream.listen((event) {
        userr = UserModel.fromSnapshot(event);
        notifyListeners();
      });
    }
  }

  Future<void> getUser() async {
    final User currentUser = _auth.currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("loggedIn") ?? false) {
      UID = currentUser.uid;
      userr = await getUserById(UID);
      notifyListeners();
    }
  }
}
