import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class ProductServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "products";
  void UploadProduct(
      {required String productName,
      required String brand,
      required String category,
      required String group,
      required String price,
      required String desc,
      required String imgList}) {
    var id = Uuid();
    String productId = id.v1();

    _firestore.collection(ref).doc(productId).set({
      'name': productName,
      'id': productId,
      'brand': brand,
      'category': category,
      'group': group,
      'desc': desc,
      'price': price,
      'imgList': imgList,
    });
  }
}
