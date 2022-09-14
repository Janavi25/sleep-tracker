import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String destinationAddress;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;
  int radius = 50;
  int shoprideradius = 50;
  bool connected = false;
  bool dev = false;
  StreamSubscription conectivity;
  Stream c;
  bool permissionBattery = false;
  AppProvider() {
    internet();
    getRadius();
  }

  void changePermission() {
    permissionBattery = true;
  }

  void clear() {
    permissionBattery = false;

    destinationAddress = null;
    _firestore = null;
    dispose();
  }

  internet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      connected = true;
      notifyListeners();
    } else {
      // internetdialog();
      connected = false;
      notifyListeners();
    }
    c = Connectivity().onConnectivityChanged;
    conectivity = c.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        connected = true;

        notifyListeners();
      } else {
        // internetdialog();
        connected = false;
        notifyListeners();
      }
    });
  }

  void getRadius() {
    _firestore.collection('adminvalues').doc('radius').get().then((value) {
      radius = value.data()['radius'];
      shoprideradius = value.data()['shoprideradius'];
      notifyListeners();
      // print(radius.toString());
    });
  }

  Future<void> internetdialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Internet'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/no internet.png'),
              Text(
                'Check Your Internet Connection',
                // style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: <Widget>[
            // FlatButton(
            //   child: Text(
            //     'OK',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            FlatButton(
              child: Text(
                'Try Again',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // internet();
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
