import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_bd/models/product.dart';

class ProductServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "products";
  // void createBrand(String name) {
  //   var id = Uuid();
  //   String brandId = id.v1();

  //   _firestore.collection('brands').doc(brandId).set({'brand': name});
  // }

  Future<List<Product>> getProducts() {
    return _firestore.collection(ref).get().then((snaps) {
      // log(snaps.docs.length.toString());
      List<Product> products = [];
      // snaps.docs.map((v) => products.add(Product.formSnapshot(v)));
      for (var snap in snaps.docs) {
        products.add(Product.fromSnapshot(snap));
      }
      log(products.length.toString());
      return products;
    });
  }

  Future<List<String>> getCategories() async {
    return _firestore.collection('categories').get().then((snaps) {
      List<String> cats = [];
      for (var snap in snaps.docs) {
        // log(snap.data().toString());
        cats.add(snap.data()['category']);
      }
      return cats;
    });
  }

  Future<List<Product>> getProductByCat(String cat) {
    return _firestore
        .collection('products')
        .where('category', isEqualTo: cat)
        .get()
        .then((snaps) {
      List<Product> catProd = [];
      for (var snap in snaps.docs) {
        catProd.add(Product.fromSnapshot(snap));
      }
      return catProd;
    });
  }

  Future<List<Product>> searchProducts({required String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(ref)
        .orderBy("name")
        .startAt([searchKey])
        .endAt(['$searchKey\uf8ff'])
        .get()
        .then((result) {
          List<Product> products = [];
          for (DocumentSnapshot product in result.docs) {
            log("loop $product");
            products.add(Product.fromSnapshot(product));
          }
          return products;
        });
  }
//   Future<List<DocumentSnapshot>> getSuggestions(String suggestion) {
//     return _firestore
//         .collection(ref)
//         .where('brand', isEqualTo: suggestion)
//         .get()
//         .then((snap) {
//       return snap.docs;
//     });
//   }
// }

}
