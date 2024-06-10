// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:medicine_bd/widgets/single_product.dart';
import 'package:provider/provider.dart';
import '../providers/product_providers.dart';
import '../routes/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // var productList = [
  //   {
  //     "name": "Napa",
  //     "picture": "assets/images/products/napa.jpg",
  //     "Group": "paracetamol",
  //     "Description": "This is a good medicine",
  //     "old price": 25,
  //     "price": 20,
  //   },
  //   {
  //     "name": "Montril",
  //     "picture": "assets/images/products/montril.jpg",
  //     "Group": "paracetamol",
  //     "Description": "This is a good medicine",
  //     "old price": 100,
  //     "price": 50,
  //   },
  //   {
  //     "name": "Dental Floss1",
  //     "picture": "assets/images/products/floss.jpg",
  //     "Group": "paracetamol",
  //     "Description": "This is a good medicine",
  //     "old price": 150,
  //     "price": 130,
  //   },
  //   {
  //     "name": "Oximeter1",
  //     "picture": "assets/images/products/oximeter.jpg",
  //     "Group": "paracetamol",
  //     "Description": "This is a good medicine",
  //     "old price": 1500,
  //     "price": 1000,
  //   },
  //   {
  //     "name": "Dental Floss2",
  //     "picture": "assets/images/products/floss.jpg",
  //     "Group": "paracetamol",
  //     "Description": "This is a good medicine",
  //     "price": 130,
  //   },
  //   {
  //     "name": "Oximeter2",
  //     "picture": "assets/images/products/oximeter.jpg",
  //     "Group": "paracetamol",
  //     "Description": "This is a good medicine",
  //     "price": 1000,
  //   },
  //   {
  //     "name": "Dental Floss",
  //     "picture": "assets/images/products/floss.jpg",
  //     "Group": "paracetamol",
  //     "Description": "This is a good medicine",
  //     "price": 130,
  //   },
  //   {
  //     "name": "Oximeter",
  //     "picture": "assets/images/products/oximeter.jpg",
  //     "Group": "paracetamol",
  //     "Description": "This is a good medicine",
  //     "price": 1000,
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return GridView.builder(
      itemCount: productProvider.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return SingleProd(
          prodName: productProvider.products[index].name!,
          prodPicture: productProvider.products[index].imgList!,
          // prodOldPrice: productList[index]['old price'],
          category: productProvider.products[index].category!,
          prodPrice: productProvider.products[index].price!,
          grp: productProvider.products[index].group!,
          desc: productProvider.products[index].desc!,
        );
      },
    );
  }
}
