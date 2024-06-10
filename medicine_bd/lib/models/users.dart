import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "uid";
  static const USERNAME = "username";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";

  String? _name;
  String? _email;
  String? _id;
  String? _stripeId;

  String? get name => _name;
  String? get email => _email;
  String? get id => _id;
  String? get stripeID => _stripeId;

  UserModel.formSnapshot(DocumentSnapshot snaps) {
    // log(snap.data().toString());
    Map<String, dynamic> snap = snaps.data() as Map<String, dynamic>;
    _name = snap[USERNAME];
    _email = snap[EMAIL];
    _id = snap[ID];
    _stripeId = snap[STRIPE_ID] ?? "";
  }
}
