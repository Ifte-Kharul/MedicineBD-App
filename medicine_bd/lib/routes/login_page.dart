import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:medicine_bd/constants/loading.dart';
import 'package:medicine_bd/routes/homepage.dart';
import 'package:medicine_bd/routes/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../providers/user_providers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookAuth fbAuth = FacebookAuth.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  late SharedPreferences preferences;
  bool loading = false;
  bool isLogedIn = false;
  bool logged = false;
  AccessToken? isFbLogedIn;
  String name = " ";
  String photoURL = " ";
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  // @override
  // void initState() {
  //   isSignedIn();
  //   super.initState();
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLogedIn = await googleSignIn.isSignedIn();
    isFbLogedIn = await fbAuth.accessToken;

    // bool logged = firebaseAuth.currentUser!.uid.isNotEmpty;
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        logged = true;
      });
    }
    log(logged.toString());
    if (isLogedIn || isFbLogedIn != null || logged) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> handleGoogleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      UserCredential firebaseUser =
          await firebaseAuth.signInWithCredential(credential);
      User? fUser = firebaseUser.user;
      if (fUser != null) {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection("user")
            .where("id", isEqualTo: fUser.uid)
            .get();
        final List<DocumentSnapshot> docs = result.docs;
        if (docs.isEmpty) {
          FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
            "id": fUser.uid,
            "username": fUser.displayName,
            "profilePicture": fUser.photoURL,
            "email": fUser.email,
          });
          await preferences.setString("id", fUser.uid);
          await preferences.setString("username", fUser.displayName!);
          await preferences.setString("profilepicture", fUser.photoURL!);
          await preferences.setString("email", fUser.email!);
        } else {
          await preferences.setString("id", docs[0]['id']);
          await preferences.setString("username", docs[0]['username']);
          await preferences.setString("email", docs[0]['email']);
          await preferences.setString(
              "profilepicture", docs[0]['profilepicture']);
        }
        Fluttertoast.showToast(msg: "Login was successfull");
        setState(() {
          loading = false;
        });

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => HomePage()));
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Load()
          : Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.orange[900]!,
                Colors.orange[800]!,
                Colors.orange[400]!
              ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Welcome to MedicineBD",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              const BoxShadow(
                                                  color: Color.fromRGBO(
                                                      225, 95, 27, .3),
                                                  blurRadius: 20,
                                                  offset: Offset(0, 10))
                                            ]),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]!))),
                                              child: TextFormField(
                                                controller: _emailController,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Email or Phone number",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]!))),
                                              child: TextFormField(
                                                controller: _passwordController,
                                                obscureText: true,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "Password",
                                                        hintStyle:
                                                            TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                        border:
                                                            InputBorder.none),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Password can't be empty";
                                                  } else if (value.length < 6) {
                                                    return "length of password must be greater than 6";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const Text(
                                        "Forgot Password?",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          // loginWithEmail();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (!await user.signIn(
                                                _emailController.text,
                                                _passwordController.text)) {
                                              // _key.currentState!
                                              //     .showBottomSheet(
                                              //   (_) {
                                              //     return SnackBar(
                                              //       content:
                                              //           Text("Sign in Failed"),
                                              //     );
                                              //   },
                                              // );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Login Failed")));
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.orange[900]),
                                          child: const Center(
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Don't Have an Account?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        SignUpPage(),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                "SignUp",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.orange[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Continue with social media",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: (() {
                                                facebookLogin();
                                              }),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.blue),
                                                child: const Center(
                                                  child: Text(
                                                    "Facebook",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: handleGoogleSignIn,
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Color(0xffcf4332)),
                                                child: const Center(
                                                  child: Text(
                                                    "Google",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  void loginWithEmail() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (credential.user != null) {
        final ref = FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(credential.user!.uid);

        final snapshot = await ref.get();
        if (snapshot.value != null) {
          log(snapshot.child("email").value.toString());
          await preferences.setString(
              "id", snapshot.child("id").value.toString());
          await preferences.setString(
              "username", snapshot.child("username").value.toString());
          // await preferences.setString("profilepicture", fUser.photoURL!);
          await preferences.setString(
              "email", snapshot.child("email").value.toString());
        }

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    // final User? user = (await firebaseAuth.signInWithEmailAndPassword(
    //         email: _emailController.text, password: _passwordController.text))
    //     .user;
    // if (user != null) {
    //   // ignore: use_build_context_synchronously
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (ctx) => const HomePage()));
    // }
  }

  void facebookLogin() async {
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile', '']);

    if (loginResult.status == LoginStatus.success) {
      // _accessToken = loginResult.accessToken;

      AuthCredential credential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential firebaseUser =
          await firebaseAuth.signInWithCredential(credential);
      User? fbUser = firebaseUser.user;
      if (fbUser != null) {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection("user")
            .where("id", isEqualTo: fbUser.uid)
            .get();
        final List<DocumentSnapshot> docs = result.docs;
        if (docs.isEmpty) {
          FirebaseFirestore.instance.collection("users").doc(fbUser.uid).set({
            "id": fbUser.uid,
            "username": fbUser.displayName,
            "profilePicture": fbUser.photoURL,
            "email": fbUser.email,
          });
          await preferences.setString("id", fbUser.uid);
          await preferences.setString("username", fbUser.displayName!);
          await preferences.setString("profilepicture", fbUser.photoURL!);
          await preferences.setString("email", fbUser.email!);
        } else {
          await preferences.setString("id", docs[0]['id']);
          await preferences.setString("username", docs[0]['username']);
          await preferences.setString("email", docs[0]['email']);
          await preferences.setString(
              "profilepicture", docs[0]['profilepicture']);
        }
        Fluttertoast.showToast(msg: "Login was successfull");
        setState(() {
          loading = false;
        });

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => HomePage()));
      }
      // final userInfo = await FacebookAuth.instance.getUserData();
      // var _userData = userInfo;
      // log(_userData.toString());
    } else {
      print('ResultStatus: ${loginResult.status}');
      print('Message: ${loginResult.message}');
    }
  }
}
