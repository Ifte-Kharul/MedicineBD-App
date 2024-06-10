// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:admin_medic/models/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserModel> userList = [];
  UserProvider.initialyze() {
    getUser();
  }
  void getUser() async {
    _firestore.collection("users").get().then((snap) {
      // List<UserModel> user = [];
      for (var u in snap.docs) {
        userList.add(UserModel.formSnapshot(u));
      }
      // log(userList.toString());
    });
  }
}
