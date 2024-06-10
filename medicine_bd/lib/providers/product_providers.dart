import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:medicine_bd/db/products.dart';
import 'package:medicine_bd/models/product.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<Product> _products = [];
  List<Product> productSearched = [];
  List<Product> productByCat = [];
  List<String> categoyList = [];
  List<Product> get products => _products;
  ProductProvider.initialyze() {
    _getProducts();
    notifyListeners();
    _getCats();
  }
  void _getProducts() async {
    _products = await _productServices.getProducts();
    // log(_products.toString());
    notifyListeners();
  }

  Future<List<Product>> prodByCat(String cat) async {
    productByCat = await _productServices.getProductByCat(cat);
    notifyListeners();
    return productByCat;
  }

  void _getCats() async {
    categoyList = await _productServices.getCategories();
    notifyListeners();
    log(categoyList.length.toString());
  }

  Future<List<Product>> search({required String prodName}) async {
    productSearched =
        await _productServices.searchProducts(productName: prodName);
    notifyListeners();
    return productSearched;
  }
}
