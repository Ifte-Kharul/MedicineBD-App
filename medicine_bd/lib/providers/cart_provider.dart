import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:medicine_bd/db/cart.dart';
import 'package:medicine_bd/db/users.dart';
import 'package:medicine_bd/models/cart.dart';
import 'package:medicine_bd/models/users.dart';
import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  CartServices cartService = CartServices();

  List<CartModel> cartItems = [];
  static const BRAND = 'brand';
  static const CATEGORY = 'category';
  // static const DESC = 'desc';
  static const GROUP = 'group';
  static const ID = 'id';
  static const IMGLIST = 'imgList';
  static const NAME = 'name';
  static const PRICE = 'price';
  // CartProvider.initialyze(String userId) {
  //   getCartProducts(userId);
  // }
  Future addProduct(
    String userID,
    String name,
    String price,
    String imgList,
    String quantity,
  ) async {
    Map<String, String> cartMap = {
      NAME: name,
      PRICE: price,
      'quantity': quantity.toString(),
      IMGLIST: imgList,
    };
    cartService.createItem(userID, cartMap).then((value) => true);
    notifyListeners();
  }

  int totalPrice() {
    int totalPrice = 0;
    for (var items in cartItems) {
      totalPrice += int.parse(items.quantity!) * int.parse(items.price!);
    }
    return totalPrice;
  }

  void getCartProducts(String userId) async {
    cartItems = await cartService.getCartProducts(userId);
    log(cartItems.length.toString());
    notifyListeners();
  }

  Future checkOut(String userId) async {
    await cartService.deleteAll(userId);
  }
}
