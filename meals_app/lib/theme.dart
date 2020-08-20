import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  primarySwatch: Colors.pink,
  accentColor: Colors.purple,
  fontFamily: 'Raleway',
  scaffoldBackgroundColor: Colors.white,
  textTheme: ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 28,
        ),
      ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    // elevation: 0,
    color: Colors.white,
    iconTheme: IconThemeData.fallback(),
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            color: Colors.pink,
            fontSize: 22,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.pink,
    unselectedLabelColor: Colors.grey,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
  ),
);
