import 'package:flutter/material.dart';
import 'dart:ui';
import 'screens/LandingScreen.dart';
import 'package:sem_5_project/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sem_5_project/screens/logIn_screen.dart';
import 'package:sem_5_project/screens/auth_screen1.dart';
import 'package:sem_5_project/screens/Events_Details.dart';
import 'package:sem_5_project/screens/Form_screen.dart';
import 'package:sem_5_project/screens/Forum_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    double screenWidth=window.physicalSize.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App 1',
      theme: ThemeData(primaryColor: COLOR_WHITE,accentColor: COLOR_DARK_BLUE,textTheme: screenWidth<500? TEXT_THEME_SMALL: TEXT_THEME_DEFAULT,fontFamily: "Montserrat"),
      home: AuthService(context).handleAuthState(),
      routes: {
        LandingScreen.routeName:(ctx)=>LandingScreen(""),
        EventDetails.routeName:(ctx)=> EventDetails(),
        FormDetail.routeName:(ctx)=> FormDetail(),
      },
    );
  }
}