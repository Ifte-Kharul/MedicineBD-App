import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medicine_bd/providers/product_providers.dart';
import 'package:medicine_bd/widgets/single_product.dart';
import 'package:provider/provider.dart';

class SearchedProd extends StatelessWidget {
  final String cat;
  const SearchedProd({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    var prodProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          cat,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: prodProvider.productSearched.length,
        itemBuilder: ((context, i) => SingleProd(
              prodName: prodProvider.productSearched[i].name!,
              category: prodProvider.productSearched[i].category!,
              prodPicture: prodProvider.productSearched[i].imgList!,
              prodPrice: prodProvider.productSearched[i].price!,
              grp: prodProvider.productSearched[i].group!,
              desc: prodProvider.productSearched[i].desc!,
            )),
      ),
    );
  }
}
