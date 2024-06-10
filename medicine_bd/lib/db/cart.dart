import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_bd/models/cart.dart';
import 'package:medicine_bd/routes/cart.dart';
import 'package:uuid/uuid.dart';

class CartServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'cart_items';
  Future createItem(String userId, Map<String, String> cart) async {
    var id = Uuid();
    String cartID = id.v1();
    log(userId.toString());
    _firestore
        .collection("users")
        .doc(userId)
        .collection("cart_items")
        .add(cart)
        .then((_) {
      return true;
    });
  }

  Future<List<CartModel>> getCartProducts(String userId) {
    return _firestore
        .collection("users")
        .doc(userId)
        .collection("cart_items")
        .get()
        .then((snaps) {
      // log(snaps.docs.length.toString());
      List<CartModel> Cartproducts = [];
      // snaps.docs.map((v) => products.add(Product.formSnapshot(v)));
      log(userId);
      for (var snap in snaps.docs) {
        log(snap.data().toString());
        Cartproducts.add(CartModel.fromSnapshot(snap.id, snap));
      }
      // log(Cartproducts[0].toString());
      return Cartproducts;
    });
  }

  Future deleteAll(String userId) async {
    _firestore
        .collection("users")
        .doc(userId)
        .collection("cart_items")
        .get()
        .then((snaps) {
      for (var sn in snaps.docs) {
        sn.reference.delete();
      }
    });
  }
}
