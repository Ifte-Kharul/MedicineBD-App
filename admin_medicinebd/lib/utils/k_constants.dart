// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const Color kAppbarColor = Color(0xffdd0e0c);
final kHintTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  // ignore: prefer_const_literals_to_create_immutables
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
const KmainPageButtonStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15.0,
);
const KredAccent = Color(0xffDF041A);

const KTextFieldLevelStyle = TextStyle(
    fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.grey);
