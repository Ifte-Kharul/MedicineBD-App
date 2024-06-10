import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:medicine_bd/db/users.dart';
import 'package:medicine_bd/routes/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/loading.dart';
import '../providers/user_providers.dart';
import 'homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool loading = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late SharedPreferences preferences;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _key = GlobalKey<ScaffoldState>();
  String gender = "male";
  String groupvalue = "male";
  UserServices _userServices = UserServices();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: Container(
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
                    "SignUp",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome to MedicineBD Rgistration",
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
                child: user.status == Status.Authenticating
                    ? Load()
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
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        const BoxShadow(
                                            color:
                                                Color.fromRGBO(225, 95, 27, .3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      //FullName
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]!))),
                                        child: TextFormField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                              hintText: "Enter your FullName",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      //gender
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]!))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ListTile(
                                                title: Text("Male"),
                                                leading: Radio(
                                                  value: "male",
                                                  groupValue: groupvalue,
                                                  onChanged: (e) =>
                                                      valueChanged(e),
                                                  activeColor:
                                                      Colors.orange[700],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListTile(
                                                title: Text("Female"),
                                                leading: Radio(
                                                  value: "female",
                                                  groupValue: groupvalue,
                                                  onChanged: (e) =>
                                                      valueChanged(e),
                                                  activeColor:
                                                      Colors.orange[700],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //email
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]!))),
                                        child: TextFormField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                              hintText: "Enter your Email",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      //password
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]!))),
                                        child: TextFormField(
                                          controller: _passwordController,
                                          obscureText: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Password can't be empty";
                                            } else if (value.length < 6) {
                                              return "length of password must be greater than 6";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Password",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      //Confirm Password Field
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]!))),
                                        child: TextFormField(
                                          controller:
                                              _confirmPasswordController,
                                          obscureText: true,
                                          validator: (value) {
                                            if (value !=
                                                _passwordController.text) {
                                              return "Password don't match";
                                            } else if (value == null ||
                                                value.isEmpty) {
                                              return "password can not be empty";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Confirm Password",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  //Button
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (!await user.signUp(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        gender: gender,
                                        name: _nameController.text,
                                      )) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("SignUp Failed")));
                                        // _key.currentState!.showBottomSheet(
                                        //   (_) {
                                        //     return SnackBar(
                                        //       content: Text("Sign Up Failed"),
                                        //     );
                                        //   },
                                        // );
                                      } else {
                                        // await preferences.setString(
                                        //     "id",
                                        //     snapshot
                                        //         .child("id")
                                        //         .value
                                        //         .toString());
                                        // await preferences.setString(
                                        //     "username",
                                        //     snapshot
                                        //         .child("username")
                                        //         .value
                                        //         .toString());
                                        // // await preferences.setString("profilepicture", fUser.photoURL!);
                                        // await preferences.setString(
                                        //     "email",
                                        //     snapshot
                                        //         .child("email")
                                        //         .value
                                        //         .toString());
                                      }
                                    }
                                    // validate().then((_) {
                                    //   Navigator.pushReplacement(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (ctx) =>
                                    //               const HomePage()));
                                    // });
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.orange[900]),
                                    child: const Center(
                                      child: Text(
                                        "SignUp",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already Have an Account?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (ctx) => LoginPage(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.orange[900],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))
                                  ],
                                ),
                                // const SizedBox(
                                //   height: 50,
                                // ),
                                // const Text(
                                //   "Continue with social media",
                                //   style: TextStyle(color: Colors.grey),
                                // ),
                                // const SizedBox(
                                //   height: 30,
                                // ),
                                // Row(
                                //   children: <Widget>[
                                //     Expanded(
                                //       child: Container(
                                //         height: 50,
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(50),
                                //             color: Colors.blue),
                                //         child: const Center(
                                //           child: Text(
                                //             "Facebook",
                                //             style: TextStyle(
                                //                 color: Colors.white,
                                //                 fontWeight: FontWeight.bold),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     const SizedBox(
                                //       width: 30,
                                //     ),
                                //     Expanded(
                                //       child: GestureDetector(
                                //         child: Container(
                                //           height: 50,
                                //           decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(50),
                                //               color: Color(0xffcf4332)),
                                //           child: const Center(
                                //             child: Text(
                                //               "Google",
                                //               style: TextStyle(
                                //                   color: Colors.white,
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     )
                                //   ],
                                // )
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

  valueChanged(e) {
    setState(() {
      groupvalue = e;
      gender = e;
    });
  }

  Future<void> validate() async {
    var formstate = _formKey.currentState!.validate();

    if (formstate) {
      User? user = firebaseAuth.currentUser;
      if (user == null) {
        // UserCredential createUser =
        //     await firebaseAuth.createUserWithEmailAndPassword(
        //         email: _emailController.text,
        //         password: _passwordController.text);
        // User? user = createUser.user;
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((userCr) => {
                  _userServices
                      .createUser(userCr.user!.uid.toString(), <String, String>{
                    "username": _nameController.text,
                    "email": userCr.user!.email!,
                    "id": userCr.user!.uid,
                    "gender": gender,
                  })
                })
            .catchError((e) {
          log(e.toString());
        });
      } else {
        log("not done");
      }
    }
  }
}
