import 'dart:developer';

import 'package:admin_medic/db/brand.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowBrand extends StatefulWidget {
  const ShowBrand({super.key});

  @override
  State<ShowBrand> createState() => _ShowBrandState();
}

class _ShowBrandState extends State<ShowBrand> {
  BrandService brandService = BrandService();
  List<String> brands = [];
  @override
  void initState() {
    getBrands();
    super.initState();
  }

  getBrands() async {
    List<DocumentSnapshot> brand = await brandService.getBrands();
    for (int i = 0; i < brand.length; i++) {
      brands.add(brand[i]['brand']);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brands List"),
      ),
      body: ListView.builder(
          itemCount: brands.length,
          itemBuilder: (context, i) => Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              padding: EdgeInsets.all(10.0),
              color: Colors.grey,
              child: ListTile(title: Text(brands[i])))),
    );
  }
}
