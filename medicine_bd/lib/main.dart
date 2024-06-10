import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicine_bd/providers/cart_provider.dart';
import 'package:medicine_bd/providers/product_providers.dart';
import 'package:medicine_bd/providers/user_providers.dart';
import 'package:medicine_bd/routes/login.dart';
import 'package:medicine_bd/routes/login_page.dart';
import 'package:medicine_bd/routes/splash.dart';
import 'package:provider/provider.dart';

import 'constants/k_colors.dart';
import 'routes/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => UserProvider.initialize()),
        ),
        ChangeNotifierProvider(
            create: (context) => ProductProvider.initialyze()),
        ChangeNotifierProvider(
          create: ((context) => CartProvider()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medic',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            color: kAppbarColor,
          )),
      // home: HomePage(),
      home: ScreenController(),
    );
  }
}

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Splash();

      case Status.Authenticated:
        return HomePage();
      case Status.Authenticating:
        return LoginPage();

      // case Status.Unauthenticated:
      //   // TODO: Handle this case.
      //   break;
      default:
        return LoginPage();
    }
  }
}
