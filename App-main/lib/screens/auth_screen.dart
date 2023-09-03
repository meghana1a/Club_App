// import 'package:flutter/material.dart';
// import 'package:sem_5_project/screens/logIn_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sem_5_project/screens/LandingScreen.dart';
//
//
// class AuthScreen extends StatefulWidget {
//   const AuthScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//
//   Future<UserCredential> _submitAuthForm(String email) async{
//          print(email);
//           final GoogleSignInAccount? googleUser=await GoogleSignIn(
//             scopes: <String>["email"]).signIn();
//           final GoogleSignInAuthentication googleAuth=await googleUser!.authentication;
//           final credential= GoogleAuthProvider.credential(
//             accessToken: googleAuth.accessToken,
//             idToken: googleAuth.idToken,
//           );
//           return await FirebaseAuth.instance.signInWithCredential(credential);
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LogInScreen(_submitAuthForm),
//     );
//   }
// }
//
// class AuthService{
//   handleAuthState(){
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context,snapshot){
//          if(snapshot.hasData){
//            return LandingScreen();
//          }
//          else {
//            return AuthScreen();
//          }
//         }
//     );
//   }
// }
