import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(color: Colors.black),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  primarySwatch: Colors.lightBlue,
  iconTheme: const IconThemeData(color: Colors.lightBlueAccent),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlueAccent),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  cardTheme: CardTheme(
    // surfaceTintColor: Colors.black,
    // color: Colors.white,
    elevation: 2.0,
    color: Colors.white,

    margin: EdgeInsets.zero,

    shadowColor: Colors.blueGrey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.circular(15),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xff333739),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff333739),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  primarySwatch: Colors.lightBlue,

  iconTheme: const IconThemeData(color: Colors.lightBlueAccent),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlueAccent,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xff333739),
    elevation: 0,
    selectedItemColor: Colors.lightBlueAccent,
    unselectedItemColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 15.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.circular(5),
    ),
  ),
);
