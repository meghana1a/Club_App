import 'package:flutter/material.dart';
import 'package:sem_5_project/screens/logIn_screen.dart';
import 'package:sem_5_project/screens/LandingScreen.dart';
import 'package:sem_5_project/screens/logIn_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
  BuildContext? ctx;
  AuthService(context){
    ctx=context;
  }


  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot)  {
          // print("snapshot");
          // print(snapshot);
          if (snapshot.hasData) {
            String? _userName=FirebaseAuth.instance.currentUser!.displayName;
            String? _userEmail=FirebaseAuth.instance.currentUser!.email;
            FirebaseFirestore.instance.collection('users').doc(_userName).set({
              'userEmail': _userEmail,
            });
            print(FirebaseAuth.instance.currentUser!.displayName);
            return LandingScreen(FirebaseAuth.instance.currentUser!.displayName!);
          } else {

            return LogInScreen();
          }
        });
  }
  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("id  ");
    print(googleAuth.accessToken);
    print(googleAuth.idToken);

    // Once signed in, return the UserCredential
    var result=await FirebaseAuth.instance.signInWithCredential(credential);
    var _mailId=result.user!.email;
    print("id");
    print(_mailId!.substring(0,_mailId.indexOf('.')));
    // if(!_mailId.contains("ssn.edu.in"))
    //       { print("YESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    //         showDialog(
    //           context: ctx!,
    //         builder: (ctx)=> AlertDialog(
    //           title: Text('Error'),
    //           content: Text(
    //             'Please log in with your ssn mail id!',
    //           ),
    //           actions: [
    //             TextButton(
    //                 onPressed: (){
    //                   Navigator.of(ctx).pop();
    //                 },
    //                 child: Text('okay')),
    //           ],
    //         )
    //       );
    //         // return null;
    //
    //       }



    //return result;
  }



}