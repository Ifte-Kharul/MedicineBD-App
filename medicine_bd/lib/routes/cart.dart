import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine_bd/providers/cart_provider.dart';
import 'package:medicine_bd/providers/user_providers.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: Row(
          children: <Widget>[
            Text('Cart'),
            Icon(Icons.shopping_cart),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: CartItem(),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('Total'),
                subtitle: Text(cartProvider.totalPrice().toString()),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () async {
                  cartProvider.checkOut(userProvider.upid).then(((value) =>
                      Fluttertoast.showToast(msg: "Cart is Now empty")));
                  Navigator.of(context).pop();
                },
                child: Text(
                  'CheckOut',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
