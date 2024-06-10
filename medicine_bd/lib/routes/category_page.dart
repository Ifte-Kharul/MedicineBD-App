import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medicine_bd/providers/product_providers.dart';
import 'package:medicine_bd/routes/genral_prod.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    var prodProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
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
      body: ListView.builder(
        itemCount: prodProvider.categoyList.length,
        itemBuilder: ((context, index) => GestureDetector(
              onTap: () async {
                await prodProvider.prodByCat(prodProvider.categoyList[index]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) =>
                        ProPage(cat: prodProvider.categoyList[index])),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 2.0),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey),
                  gradient: LinearGradient(
                    colors: [Colors.white10, Colors.red, Colors.white],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: ListTile(
                  leading: const Icon(Icons.category),
                  title: Text(prodProvider.categoyList[index]),
                  trailing: const Icon(Icons.arrow_right_alt_rounded),
                ),
              ),
            )),
      ),
    );
  }
}
