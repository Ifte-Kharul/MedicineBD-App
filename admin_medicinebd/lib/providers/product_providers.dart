import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/prod_model.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> products = [];
  List<Product> productSearched = [];
  List<Product> productByCat = [];
  List<String> categoyList = [];
  // List<Product> get products => _products;
  ProductProvider.initialyze() {
    getProducts();
    getCats();
    notifyListeners();
  }
  // void getProducts() async {
  //   _products = await _getProducts();
  //   // log(_products.toString());
  //   notifyListeners();
  // }

  Future<List<Product>> getProducts() {
    return _firestore.collection('products').get().then((snaps) {
      // log(snaps.docs.length.toString());
      // List<Product> products = [];
      // snaps.docs.map((v) => products.add(Product.formSnapshot(v)));
      for (var snap in snaps.docs) {
        products.add(Product.fromSnapshot(snap));
      }
      log(products.length.toString());
      notifyListeners();
      return products;
    });
  }

  void getCats() async {
    categoyList = await _getCategories();
    notifyListeners();
    log(categoyList.length.toString());
  }

  Future<List<String>> _getCategories() async {
    return _firestore.collection('categories').get().then((snaps) {
      List<String> cats = [];
      for (var snap in snaps.docs) {
        // log(snap.data().toString());
        cats.add(snap.data()['category']);
      }
      notifyListeners();
      return cats;
    });
  }
}
