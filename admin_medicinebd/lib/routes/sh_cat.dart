import 'package:admin_medic/db/category.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowCat extends StatefulWidget {
  const ShowCat({super.key});

  @override
  State<ShowCat> createState() => _ShowCatState();
}

class _ShowCatState extends State<ShowCat> {
  CategoryService brandService = CategoryService();
  List<String> cats = [];
  @override
  void initState() {
    getCats();
    super.initState();
  }

  getCats() async {
    List<DocumentSnapshot> cat = await brandService.getCategories();
    for (int i = 0; i < cat.length; i++) {
      cats.add(cat[i]['category']);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: ListView.builder(
          itemCount: cats.length,
          itemBuilder: (context, i) => Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              padding: EdgeInsets.all(10.0),
              color: Colors.grey,
              child: ListTile(title: Text(cats[i])))),
    );
  }
}
