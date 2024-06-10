// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medicine_bd/constants/k_colors.dart';
import 'package:medicine_bd/models/users.dart';
import 'package:medicine_bd/providers/cart_provider.dart';
import 'package:medicine_bd/providers/product_providers.dart';
import 'package:medicine_bd/providers/user_providers.dart';
import 'package:medicine_bd/routes/cart.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import './homepage.dart';
// import 'package:pharmacy/utilities/constants.dart';
// import 'package:pharmacy/pages/cart.dart';

class ProductDetails extends StatefulWidget {
  final String price;
  final String picture;
  // final String oldPrice;
  final String name;
  final String grp;
  final String desc;
  final String category;
  var _qty = TextEditingController(text: "1");
  ProductDetails(
      {required this.name,
      // required this.oldPrice,
      required this.category,
      required this.picture,
      required this.price,
      required this.grp,
      required this.desc});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kAppbarColor,
        title: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(),
                )),
            child: Text('Pharmacy')),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     Icons.search,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              cartProvider.getCartProducts(user.upid);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Cart(),
              ));
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            color: Colors.white54,
            child: GridTile(
              child: Container(
                child: Image.network(widget.picture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  title: Row(
                    children: <Widget>[
                      // Expanded(
                      //   child: Text(
                      //     '\৳${widget.oldPrice}',
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       decoration: TextDecoration.lineThrough,
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Text(
                          '\৳${widget.price}',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // =========First Row of Button==========
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              //SIze BUtton Start
              // Expanded(
              //   child: MaterialButton(
              //     onPressed: () {
              //       showDialog(
              //         context: context,
              //         builder: (context) => AlertDialog(
              //           title: Text('Buying Option'),
              //           content: Text('Choose an Option'),
              //           actions: <Widget>[
              //             MaterialButton(
              //               onPressed: () => Navigator.of(context).pop(),
              //               child: Text('Close'),
              //             )
              //           ],
              //         ),
              //       );
              //     },
              //     color: Colors.white,
              //     textColor: Colors.grey,
              //     child: Row(
              //       children: <Widget>[
              //         Expanded(
              //           child: Text('Buying Option'),
              //         ),
              //         Expanded(
              //           child: Icon(Icons.arrow_drop_down),
              //         )
              //       ],
              //     ),
              //   ),
              // ), //Color button
              //Qty button

              Expanded(
                flex: 1,
                child: Text('Quantity'),
              ),
              Expanded(
                  flex: 2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: widget._qty,
                  )),
              //Size button
            ],
          ),
          Row(
            children: <Widget>[
              //Buy Now button
              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: () {},
                  color: kAppbarColor,
                  textColor: Colors.white,
                  child: Text('Buy Now'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_shopping_cart),
                color: kAppbarColor,
                onPressed: () async {
                  log(user.upid);
                  cartProvider.addProduct(user.upid, widget.name, widget.price,
                      widget.picture, widget._qty.text);
                  cartProvider.getCartProducts(user.upid);
                },
              ),
              // IconButton(
              //   icon: Icon(Icons.favorite_border),
              //   color: kAppbarColor,
              //   onPressed: () {},
              // )
            ],
          ),
          Divider(),
          ListTile(
            title: Text('Description'),
            subtitle: Text(widget.desc),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  12.0,
                  5.0,
                  5.0,
                  5.0,
                ),
                child: Text(
                  'Product name',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.name),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  12.0,
                  5.0,
                  5.0,
                  5.0,
                ),
                child: Text(
                  'Group',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.grp),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Related Products'),
          ),
          Container(
            height: 360.0,
            child: SimilarProducts(widget.category),
          )
        ],
      ),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  final String category;
  SimilarProducts(this.category);
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  @override
  Widget build(BuildContext context) {
    var prod = Provider.of<ProductProvider>(context);
    var p = prod.prodByCat(widget.category);

    return GridView.builder(
      itemCount: prod.productByCat.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return SimilarSingleProd(
          prodName: prod.productByCat[index].name,
          prodPicture: prod.productByCat[index].imgList,
          // prodOldPrice: prod.productByCat[index]['old price'],
          prodPrice: prod.productByCat[index].price,
          grp: prod.productByCat[index].group,
          desc: prod.productByCat[index].desc,
          category: prod.productByCat[index].category,
        );
      },
    );
  }
}

class SimilarSingleProd extends StatelessWidget {
  final prodName;
  final prodPicture;
  final prodOldPrice;
  final prodPrice;
  final desc;
  final grp;
  final category;
  SimilarSingleProd(
      {this.prodName,
      this.prodPicture,
      this.prodOldPrice,
      this.prodPrice,
      this.desc,
      this.grp,
      this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Hero(
          tag: prodName,
          child: Material(
            child: InkWell(
              onTap: () {
                print('I love you');
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetails(
                    category: category,
                    name: prodName,
                    picture: prodPicture,
                    price: prodPrice,
                    // oldPrice: prodOldPrice,
                    desc: desc,
                    grp: grp,
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
                      "\৳ $prodPrice ",
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
