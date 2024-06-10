import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class BrandService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "brands";
  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();

    _firestore.collection('brands').doc(brandId).set({'brand': name});
  }

  Future<List<DocumentSnapshot>> getBrands() {
    return _firestore.collection(ref).get().then((snaps) {
      return snaps.docs;
    });
  }

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) {
    return _firestore
        .collection(ref)
        .where('brand', isEqualTo: suggestion)
        .get()
        .then((snap) {
      return snap.docs;
    });
  }
}
