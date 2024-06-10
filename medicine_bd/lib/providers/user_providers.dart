// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:medicine_bd/db/users.dart';
import 'package:medicine_bd/models/users.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class UserProvider with ChangeNotifier {
  late String upid;
  UserModel? userModel;
  FirebaseAuth? _auth;
  UserCredential? cred;
  User? _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  User? get user => _user;
  UserServices _userServices = UserServices();
  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth!.authStateChanges().listen(_onStateChange);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      cred = await _auth!
          .signInWithEmailAndPassword(email: email, password: password);

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  String get userInfo {
    return cred!.user!.email.toString();
  }

  Future<bool> signUp(
      {required String name,
      required String email,
      required String password,
      required String gender}) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth!
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential credential) {
        User? user = credential.user;
        Map<String, String> values = {
          "username": name,
          "email": email,
          "id": user!.uid,
          "gender": gender,
        };
        _userServices.createUser(user.uid, values);
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth!.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Map<String, String?> get getUserInfo => {
        'name': _auth!.currentUser!.displayName,
        'email': _auth!.currentUser!.email
      };

  Future _onStateChange(User? user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      // log(user.uid.toString());
      upid = user.uid.toString();
      userModel = await _userServices.getUserById(user.uid.toString());
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
