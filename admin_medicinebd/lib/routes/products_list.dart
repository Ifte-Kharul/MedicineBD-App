import 'package:admin_medic/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    var pProvider = Provider.of<ProductProvider>(context, listen: true);

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
        itemCount: pProvider.products.length,
        itemBuilder: ((context, index) => GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: ListTile(
                  leading: Container(
                    height: 40,
                    child: Image.network(pProvider.products[index].imgList!),
                  ),
                  title: Text(pProvider.products[index].name!),
                  subtitle: Row(
                    children: [
                      const Text(
                        "Group : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(pProvider.products[index].group!),
                      SizedBox(
                        width: 10.0,
                      ),
                      const Text(
                        "Category : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(pProvider.products[index].category!),
                    ],
                  ),
                  // trailing: const Icon(Icons.arrow_right_alt_rounded),
                ),
              ),
            )),
      ),
    );
  }
}
