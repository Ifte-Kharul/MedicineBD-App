import 'package:admin_medic/providers/product_providers.dart';
import 'package:admin_medic/providers/user_provider.dart';
import 'package:admin_medic/routes/admin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: ((context) => ProductProvider.initialyze()),
      ),
      ChangeNotifierProvider(
        create: ((context) => UserProvider.initialyze()),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Admin(),
    ),
  ));
}
