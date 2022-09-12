import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const Number = "number";
  static const ID = "id";

  static const Name = "name";
  static const Image = "image";
  static const Email = "email";
  static const Age = "age";

  // static const VALUESET = "valueset";

//  static const ORDERS = "orders";

  String? _number;
  String? _id;

  String? _name;
  String? _image;
  String? _email;

  // bool _valueset;
  // List _notification;

//  List _orders;

  String get number => _number!;

  String get name => _name!;
  String get email => _email!;

  String get image => _image!;

  // List get notification => _notification;
//  List get orders => _orders;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = {};
    data = snapshot.data() as Map;

    _number = data[Number];

    _id = data[ID];

    _image = data[Image] ?? '';
    _email = data[Email] ?? '';

    _name = data[Name] ?? '';

    // _valueset = data['valueset'] ?? 0;
    // _notification = data['notification'] ?? [];
//    _orders = data[ORDERS] ?? [];

    // _passbook =data[PASSBOOK] ?? [];
  }
}
