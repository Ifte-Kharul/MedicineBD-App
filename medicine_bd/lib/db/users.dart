import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medicine_bd/models/users.dart';

class UserServices {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "users";

  createUser(String uid, Map<String, String> value) {
    // _database.ref().child(ref).child(uid).set(value).catchError((e) {
    //   log(e.toString());
    // });
    FirebaseFirestore.instance.collection(ref).doc(uid).set(value);
  }

  Future<UserModel> getUserById(String Id) =>
      FirebaseFirestore.instance.collection(ref).doc(Id).get().then((value) {
        // Map<String,dynamic>? m=value.data();

        return UserModel.formSnapshot(value);
      });
}
