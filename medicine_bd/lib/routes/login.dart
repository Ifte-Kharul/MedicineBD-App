// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:medicine_bd/constants/k_colors.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:medicine_bd/routes/homepage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:flutter_facebook_login/flutter_facebook_login.dart';

// import 'homepage.dart';
// //import 'package:http/http.dart' as http;
// //import 'package:intl/intl.dart';
// //import 'package:pharmacy/utilities/GoBackButton.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _auth = FirebaseAuth.instance;
//   // final _googleUser = GoogleSignIn(scopes: ['email']);
//   // final _facebookuser = FacebookLogin();
//   String? email;
//   String? name;
//   String? pass;
//   bool _rememberMe = false;
//   bool spiner = false;
//   bool isLoggedIn = false;

//   Widget _buildEmailTF() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Email',
//           style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             keyboardType: TextInputType.emailAddress,
//             style: TextStyle(
//               color: Colors.black,
//               fontFamily: 'openSans',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.email,
//                 color: Colors.black,
//               ),
//               hintText: 'Enter your Email',
//               hintStyle: kHintTextStyle,
//             ),
//             onChanged: (value) {
//               email = value;
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordTF() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Password',
//           style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             obscureText: true,
//             style: TextStyle(
//               color: Colors.black,
//               fontFamily: 'openSans',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.lock,
//                 color: Colors.black,
//               ),
//               hintText: 'Enter your Password',
//               hintStyle: kHintTextStyle,
//             ),
//             onChanged: (value) {
//               pass = value;
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildForgotPasswordBtn() {
//     return Container(
//       alignment: Alignment.centerRight,
//       child: TextButton(
//         onPressed: () => print('Forgot Password Button Pressed'),
//         // padding: EdgeInsets.only(right: 0.0),
//         child: Text(
//           'Forgot Password?',
//           style: kLabelStyle,
//         ),
//       ),
//     );
//   }

//   Widget _buildRememberMeCheckbox() {
//     return Container(
//       height: 20.0,
//       child: Row(
//         children: <Widget>[
//           Theme(
//             data: ThemeData(unselectedWidgetColor: Colors.grey),
//             child: Checkbox(
//               value: _rememberMe,
//               checkColor: Colors.green,
//               activeColor: Colors.white,
//               onChanged: (value) {
//                 setState(() {
//                   _rememberMe = value!;
//                 });
//               },
//             ),
//           ),
//           Text(
//             'Remember me',
//             style: kLabelStyle,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoginBtn() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child: ElevatedButton(
//         // elevation: 5.0,
//         style: ElevatedButton.styleFrom(
//           elevation: 5.0,
//           padding: EdgeInsets.all(15.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30.0),
//           ),
//           backgroundColor: Color(0xffDF041A),
//         ),
//         onPressed: () async {
//           // HomePage(mail: email);
//           setState(() {
//             spiner = true;
//           });
//           print(email);
//           try {
//             final user = await _auth.signInWithEmailAndPassword(
//                 email: email!, password: pass!);

//             if (user != null) {
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (context) => HomePage(
//                     // mail: email,
//                     ),
//               ));
//             }
//             setState(() {
//               spiner = false;
//             });
//           } catch (e) {
//             print(e);
//             setState(() {});
//           }
//         },

//         child: Text(
//           'LOGIN',
//           style: TextStyle(
//             color: Colors.white,
//             letterSpacing: 1.5,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'OpenSans',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSignInWithText() {
//     return Column(
//       children: <Widget>[
//         Text(
//           '- OR -',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         SizedBox(height: 20.0),
//         Text(
//           'Sign in with',
//           // style: kLabelStyle,
//         ),
//       ],
//     );
//   }

//   //social section Start
//   Widget _buildSocialBtn(Function() onTap, AssetImage logo) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 60.0,
//         width: 60.0,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               offset: Offset(0, 2),
//               blurRadius: 6.0,
//             ),
//           ],
//           image: DecorationImage(
//             image: logo,
//           ),
//         ),
//       ),
//     );
//   }

//   //facebook button
//   Widget _buildSocialBtnRow() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 30.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           //FacebookButon
//           // _buildSocialBtn(
//           //   () async {
//           //     FacebookLoginResult result = await _facebookuser.logIn(['email']);
//           //     FacebookAccessToken accessToken = result.accessToken;
//           //     email = accessToken.userId;

//           //     Navigator.of(context).pushReplacement(MaterialPageRoute(
//           //       builder: (context) => HomePage(
//           //         mail: email,
//           //       ),
//           //     ));
//           //   },
//           //   AssetImage(
//           //     'images/facebook.jpg',
//           //   ),
//           // ),
//           //google button
//           _buildSocialBtn(
//             () async {
//               try {
//                 await handleSignIn();
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) => HomePage(
//                       // mail: email,
//                       // userName: name,
//                       ),
//                 ));
//                 setState(() {
//                   isLoggedIn = true;
//                 });
//               } catch (e) {
//                 print(e);
//               }
//             },
//             AssetImage(
//               'images/google.jpg',
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSignupBtn() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, '/signUp');
//       },
//       child: RichText(
//         text: TextSpan(
//           children: [
//             TextSpan(
//               text: 'Don\'t have an Account? ',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             TextSpan(
//               text: 'Sign Up',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   late SharedPreferences preferences;

//   Future<void> handleSignIn() async {
//     preferences = await SharedPreferences.getInstance();
//     // setState(() {
//     //   loading = true;
//     // });
//     GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//     if (googleUser != null) {
//       GoogleSignInAuthentication googleSignInAuthentication =
//           await googleUser.authentication;
//       AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken,
//       );
//       UserCredential firebaseUser =
//           await firebaseAuth.signInWithCredential(credential);
//       User? fUser = firebaseUser.user;
//       if (fUser != null) {
//         final QuerySnapshot result = await FirebaseFirestore.instance
//             .collection("user")
//             .where("id", isEqualTo: fUser.uid)
//             .get();
//         final List<DocumentSnapshot> docs = result.docs;
//         if (docs.length == 0) {
//           FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
//             "id": fUser.uid,
//             "username": fUser.displayName,
//             "profilePicture": fUser.photoURL,
//           });
//           await preferences.setString("id", fUser.uid);
//           await preferences.setString("username", fUser.displayName!);
//           await preferences.setString("profilepicture", fUser.photoURL!);
//         } else {
//           await preferences.setString("id", docs[0]['id']);
//           await preferences.setString("username", docs[0]['username']);
//           await preferences.setString(
//               "profilepicture", docs[0]['profilepicture']);
//         }
//         Fluttertoast.showToast(msg: "Login was successfull");
//         // setState(() {
//         //   loading = false;
//         // });
//       } else {}
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ModalProgressHUD(
//         inAsyncCall: spiner,
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Container(
//             height: double.infinity,
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               padding: EdgeInsets.symmetric(
//                 horizontal: 40.0,
//                 vertical: 120.0,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'Sign In',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: 'openSans',
//                       fontSize: 30.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 30.0),
//                   _buildEmailTF(),
//                   SizedBox(
//                     height: 30.0,
//                   ),
//                   _buildPasswordTF(),
//                   _buildForgotPasswordBtn(),
//                   _buildRememberMeCheckbox(),
//                   _buildLoginBtn(),
//                   // GoBack(),
//                   _buildSignInWithText(),
//                   _buildSocialBtnRow(),
//                   _buildSignupBtn(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }







// //old
// // import 'package:flutter/material.dart';
// // import 'package:medicine_bd/routes/homepage.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';

// // class Login extends StatefulWidget {
// //   const Login({super.key});

// //   @override
// //   State<Login> createState() => _LoginState();
// // }

// // class _LoginState extends State<Login> {
// //   final GoogleSignIn googleSignIn = GoogleSignIn();
// //   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// //   // FirebaseFirestore firestore = FirebaseFirestore.instance;
// //   late SharedPreferences preferences;
// //   bool loading = false;
// //   bool isLogedIn = false;
// //   @override
// //   void initState() {
// //     isSignedIn();
// //     super.initState();
// //   }

// //   void isSignedIn() async {
// //     setState(() {
// //       loading = true;
// //     });
// //     preferences = await SharedPreferences.getInstance();
// //     isLogedIn = await googleSignIn.isSignedIn();
// //     if (isLogedIn) {
// //       Navigator.pushReplacement(
// //           context, MaterialPageRoute(builder: (context) => HomePage()));
// //     }

// //     setState(() {
// //       loading = false;
// //     });
// //   }

// //   Future<void> handleSignIn() async {
// //     preferences = await SharedPreferences.getInstance();
// //     setState(() {
// //       loading = true;
// //     });
// //     GoogleSignInAccount? googleUser = await googleSignIn.signIn();
// //     if (googleUser != null) {
// //       GoogleSignInAuthentication googleSignInAuthentication =
// //           await googleUser.authentication;
// //       AuthCredential credential = GoogleAuthProvider.credential(
// //         idToken: googleSignInAuthentication.idToken,
// //         accessToken: googleSignInAuthentication.accessToken,
// //       );
// //       UserCredential firebaseUser =
// //           await firebaseAuth.signInWithCredential(credential);
// //       User? fUser = firebaseUser.user;
// //       if (fUser != null) {
// //         final QuerySnapshot result = await FirebaseFirestore.instance
// //             .collection("user")
// //             .where("id", isEqualTo: fUser.uid)
// //             .get();
// //         final List<DocumentSnapshot> docs = result.docs;
// //         if (docs.length == 0) {
// //           FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
// //             "id": fUser.uid,
// //             "username": fUser.displayName,
// //             "profilePicture": fUser.photoURL,
// //           });
// //           await preferences.setString("id", fUser.uid);
// //           await preferences.setString("username", fUser.displayName!);
// //           await preferences.setString("profilepicture", fUser.photoURL!);
// //         } else {
// //           await preferences.setString("id", docs[0]['id']);
// //           await preferences.setString("username", docs[0]['username']);
// //           await preferences.setString(
// //               "profilepicture", docs[0]['profilepicture']);
// //         }
// //         Fluttertoast.showToast(msg: "Login was successfull");
// //         setState(() {
// //           loading = false;
// //         });
// //       } else {}
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         centerTitle: true,
// //         title: Text('Login'),
// //         elevation: 5.0,
// //       ),
// //       body: Stack(
// //         children: [
// //           Center(
// //             child: TextButton(
// //               onPressed: handleSignIn,
// //               child: Text("SignInWithGoogle"),
// //             ),
// //           ),
// //           Visibility(
// //               visible: loading,
// //               child: CircularProgressIndicator(
// //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
// //               ))
// //         ],
// //       ),
// //     );
// //   }
// // }
