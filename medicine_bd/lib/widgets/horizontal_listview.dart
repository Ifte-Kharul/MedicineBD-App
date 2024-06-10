// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:medicine_bd/constants/k_colors.dart';
import 'package:medicine_bd/providers/product_providers.dart';
import 'package:provider/provider.dart';

import '../routes/genral_prod.dart';

String Tablets_Location = "assets/logos/pill.png";
String Capsul_Location = "assets/logos/pill.png";
String Injection_Location = "assets/logos/injection.png";
String Mask_Location = "assets/logos/masks.png";
String Others_Location = "assets/logos/thermo.png";

class HorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 65,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productProvider.categoyList.length,
        itemBuilder: ((context, index) => Catagory(
              image_caption: productProvider.categoyList[index],
            )),
        // children: [

        // ],
      ),
    );
  }
}

class Catagory extends StatelessWidget {
  // final String image_location;
  final String image_caption;
  Catagory({
    required this.image_caption,
  });
  @override
  Widget build(BuildContext context) {
    var prodProvider = Provider.of<ProductProvider>(context);
    return Padding(
        padding: EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 85.0,
            // height: 300.0,
            child: GestureDetector(
              onTap: (() {
                prodProvider.prodByCat(image_caption);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProPage(cat: image_caption)));
              }),
              child: ListTile(
                title: titleWidget(),
                subtitle: Text(
                  image_caption,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kAppbarColor, fontSize: 12.0),
                ),
              ),
            ),
          ),
        ));
  }

  Widget titleWidget() {
    switch (image_caption) {
      case "Tablets":
        return Image.asset(
          Tablets_Location,
          height: 35.0,
          // width: 100.0,
        );
      case "Capsul":
        return Image.asset(
          Tablets_Location,
          height: 35.0,
          // width: 100.0,
        );
      case "Mask":
        return Image.asset(
          Mask_Location,
          height: 35.0,
          // width: 100.0,
        );
      case "Injection":
        return Image.asset(
          Injection_Location,
          height: 35.0,
          // width: 100.0,
        );
      default:
        return Image.asset(
          Others_Location,
          height: 35.0,
          // width: 100.0,
        );
    }
  }
}
