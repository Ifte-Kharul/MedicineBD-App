// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CartModel {
  static const BRAND = 'brand';
  static const CATEGORY = 'category';
  // static const DESC = 'desc';
  static const GROUP = 'group';
  static const ID = 'id';
  static const IMGLIST = 'imgList';
  static const NAME = 'name';
  static const PRICE = 'price';

//   final String id;
//   final String name;
//   final String category;
//   final String brand;
// //  final String desc;
//   final String group;
//   final String price;
//   final String imgList;
//   final int quantity;

//   CartModel(
//       {required this.id,
//       required this.name,
//       required this.category,
//       required this.brand,
//       required this.group,
//       required this.price,
//       required this.imgList,
//       required this.quantity});

  String? _id;
  String? _name;

  // String? _desc;
  String? _quantity;
  String? _price;
  String? _imgList;

  String? get id => _id;

  String? get name => _name;
  // String? get desc => _desc;
  String? get quantity => _quantity;
  String? get price => _price;
  String? get imgList => _imgList;

  CartModel.fromSnapshot(String id, DocumentSnapshot snapshot) {
    _id = id;
    _name = snapshot[NAME];
    _quantity = snapshot['quantity'];
    _price = snapshot[PRICE];
    _imgList = snapshot[IMGLIST];
    // log(_name.toString());
  }
}
