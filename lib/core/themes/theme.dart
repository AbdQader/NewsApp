import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {

  // For Light Theme
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
    ),
    primarySwatch: Colors.deepPurple,
    accentColor: Colors.deepPurpleAccent,
    primaryColor: Colors.grey[600],
    canvasColor: Colors.white,
    buttonColor: Colors.black,
    dividerColor: Colors.grey[400],
    hintColor: Colors.grey,
    focusColor: Colors.grey[200],
    textTheme: ThemeData.light().textTheme.copyWith(
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.bold,
      ),
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Colors.black87,
        fontSize: 15,
      ),
    ),
  );

  // For Dark Theme
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light
      ),
      backgroundColor: Colors.black,
      elevation: 0.0,
    ),
    primarySwatch: Colors.deepPurple,
    accentColor: Colors.deepPurpleAccent,
    primaryColor: Colors.white,
    canvasColor: Colors.black,
    buttonColor: Colors.white,
    dividerColor: Colors.grey[800],
    hintColor: Colors.grey,
    focusColor: Colors.grey[900],
    textTheme: ThemeData.dark().textTheme.copyWith(
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.bold,
      ),
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Colors.white70,
        fontSize: 15,
      ),
    ),
  );

}
