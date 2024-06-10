// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Product {
  static const BRAND = 'brand';
  static const CATEGORY = 'category';
  static const DESC = 'desc';
  static const GROUP = 'group';
  static const ID = 'id';
  static const IMGLIST = 'imgList';
  static const NAME = 'name';
  static const PRICE = 'price';

  String? _id;
  String? _name;
  String? _category;
  String? _brand;
  String? _desc;
  String? _group;
  String? _price;
  String? _imgList;

  String? get id => _id;
  String? get brand => _brand;
  String? get category => _category;
  String? get name => _name;
  String? get desc => _desc;
  String? get group => _group;
  String? get price => _price;
  String? get imgList => _imgList;

  Product.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot[ID];
    _name = snapshot[NAME];
    _category = snapshot[CATEGORY];
    _brand = snapshot[BRAND];
    _desc = snapshot[DESC];
    _group = snapshot[GROUP];
    _price = snapshot[PRICE];
    _imgList = snapshot[IMGLIST];
  }
}
