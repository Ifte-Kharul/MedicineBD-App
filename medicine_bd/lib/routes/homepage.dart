// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medicine_bd/providers/cart_provider.dart';
import 'package:medicine_bd/providers/product_providers.dart';
import 'package:medicine_bd/routes/cart.dart';
import 'package:medicine_bd/routes/category_page.dart';
import 'package:medicine_bd/routes/login_page.dart';
import 'package:medicine_bd/routes/searched_page.dart';
import 'package:medicine_bd/widgets/courosel.dart';
import 'package:medicine_bd/widgets/horizontal_listview.dart';
import 'package:medicine_bd/widgets/product_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/k_colors.dart';
import '../providers/user_providers.dart';
// import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  String photoURL = "";
  String email = "";
  final _searchController = TextEditingController();
  SharedPreferences? preferences;
  // @override
  // void didChangeDependencies() {
  //   getValues();
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    getValues();
    super.initState();
  }

  Future getValues() async {
    preferences = await SharedPreferences.getInstance();
    name = preferences!.getString("username")!;

    photoURL = preferences!.getString("profilepicture")!;
    email = preferences!.getString("email")!;
    // log(email);
    // if (name.isNotEmpty && email.isNotEmpty) {
    //   setState(() {});
    // }
    return Future.delayed(Duration.zero);
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    await FacebookAuth.instance.logOut();
    if (GoogleSignIn().currentUser != null) {
      await GoogleSignIn().signOut();
    }
    try {
      await GoogleSignIn().disconnect();
    } catch (e) {
      log(e.toString());
    }
    // preferences!.remove("profilepicture");
    // preferences!.remove("username");
    // preferences!.remove("email");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => LoginPage(),
      ),
    );
  }

  @override
  void dispose() {
    name = "";
    photoURL = "";
    email = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    var m = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Material(
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Products",
                // icon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (_searchController.text.isNotEmpty) {
                var prod = await productProvider.search(
                    prodName: _searchController.text);
                log("Prod Lenth ${prod.length}");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => SearchedProd(
                        cat: "Search For: ${_searchController.text}"))));
              }
            },
            enableFeedback: false,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              cartProvider.getCartProducts(user.upid);
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Cart()));
            },
            enableFeedback: false,
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      //Drawer
      drawer: Drawer(
        child: ListView(
          children: [
            //header
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: kAppbarColor,
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundImage: (photoURL == "")
                      ? AssetImage("assets/images/tamim.jpg") as ImageProvider
                      : NetworkImage(photoURL),
                ),
              ),
              accountName: Text(name),
              accountEmail: Text(email),
            ),
            //End Header
            //Body Start at Drawer
            InkWell(
              onTap: () {},
              child: ListTile(
                title: const Text('Homepage'),
                leading: Icon(
                  Icons.home,
                  color: kAppbarColor,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: const Text('My Account'),
                leading: Icon(
                  Icons.person,
                  color: kAppbarColor,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => CategoryList())));
              },
              child: ListTile(
                title: const Text('Categories'),
                leading: Icon(
                  Icons.dashboard,
                  color: kAppbarColor,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: const Text('My Orders'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: kAppbarColor,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                cartProvider.getCartProducts(user.upid);
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Cart()));
              },
              child: ListTile(
                title: const Text('Shopping cart'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: kAppbarColor,
                ),
              ),
            ),

            // InkWell(
            //   onTap: () {},
            //   child: ListTile(
            //     title: const Text('Favourites'),
            //     leading: Icon(
            //       Icons.favorite,
            //       color: kAppbarColor,
            //     ),
            //   ),
            // ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: const Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: const Text('About'),
                leading: Icon(
                  Icons.help,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                logout();
                user.signOut();
              },
              child: ListTile(
                title: const Text('Logout'),
                leading: Icon(
                  Icons.logout,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          //Image Carousel
          Courosel(),
          //categories text
          Padding(
            padding: EdgeInsets.all(2.0),
            child: const Text('Categories'),
          ),
          //Horizntal List View
          HorizontalListView(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: const Text('Recent Products'),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Products(),
          )
        ],
      ),
    );
  }
}
