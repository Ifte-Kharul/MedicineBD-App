import 'package:flutter/material.dart';
import 'package:medicine_bd/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  var product_on_list = [
    {
      "name": "Napa",
      "picture": "assets/images/products/napa.jpg",
      "qty": "2",
      "type": "box",
      "price": 20,
    },
    {
      "name": "Montril",
      "picture": "assets/images/products/montril.jpg",
      "qty": "2",
      "type": "single page",
      "price": 50,
    },
  ];

  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<CartProvider>(context);
    return Container(
      child: ListView.builder(
        itemCount: cartItems.cartItems.length,
        itemBuilder: (context, index) {
          return SingleProductCart(
            cartprodName: cartItems.cartItems[index].price,
            cartprodPicture: cartItems.cartItems[index].imgList,
            cartprodPrice: cartItems.cartItems[index].price,
            // cartprodType: product_on_list[index]['type'],
            cartprodQty: cartItems.cartItems[index].quantity,
          );
        },
      ),
    );
  }
}

class SingleProductCart extends StatelessWidget {
  final cartprodName;
  final cartprodPicture;

  final cartprodQty;
  final cartprodPrice;
  SingleProductCart(
      {this.cartprodName,
      this.cartprodPicture,
      this.cartprodPrice,
      this.cartprodQty});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image(
          image: NetworkImage(
            cartprodPicture,
          ),
        ),
        title: Text(cartprodName),
        subtitle: Column(
          children: <Widget>[
            // Row(
            //   children: <Widget>[
            //     Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: Text('Type'),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.all(4.0),
            //       child: Text(
            //         cartprodType,
            //         style: TextStyle(color: Colors.red),
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              alignment: Alignment.topLeft,
              // padding: EdgeInsets.only(right: 12.0),

              child: Text(
                '\৳$cartprodPrice',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                ),
              ),
            )
          ],
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: <Widget>[
              // IconButton(
              //   icon: Icon(
              //     Icons.arrow_drop_up,
              //     size: 40.0,
              //   ),
              //   onPressed: () {},
              // ),
              Text(
                '${cartprodQty}x',
                style: TextStyle(fontSize: 20.0),
              ),
              // IconButton(
              //   icon: Icon(
              //     Icons.arrow_drop_down,
              //     size: 40.0,
              //   ),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
