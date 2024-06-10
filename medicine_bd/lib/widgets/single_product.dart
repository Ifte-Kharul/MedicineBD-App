import 'package:flutter/material.dart';

import '../routes/product_details.dart';

class SingleProd extends StatelessWidget {
  final String prodName;
  final prodPicture;
  // final prodOldPrice;
  final String prodPrice;
  final String grp;
  final String desc;
  final String category;
  SingleProd(
      {required this.prodName,
      required this.prodPicture,
      // this.prodOldPrice,
      required this.category,
      required this.prodPrice,
      required this.grp,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Hero(
          tag: prodName,
          child: Material(
            child: InkWell(
              onTap: () {
                // print('I love Flutter');
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetails(
                    category: category,
                    name: prodName,
                    picture: prodPicture,
                    price: prodPrice.toString(),
                    // oldPrice: prodOldPrice.toString(),
                    grp: grp,
                    desc: desc,
                  ),
                ));
              },
              child: GridTile(
                footer: Container(
                  // height: 80.0,
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                      prodName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(
                      "৳ $prodPrice ",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    // subtitle: Text(
                    //   "\৳ $prodOldPrice",
                    //   style: TextStyle(
                    //     color: Colors.black54,
                    //     fontWeight: FontWeight.w900,
                    //     decoration: TextDecoration.lineThrough,
                    //   ),
                    // ),
                  ),
                ),
                child: Image.network(
                  prodPicture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
