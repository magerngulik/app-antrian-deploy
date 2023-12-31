import 'package:flutter/material.dart';
import 'package:get/get.dart';

get mq {
  return MediaQuery.of(Get.context!);
}

get mqs {
  return MediaQuery.of(Get.context!).size;
}

//OLD VERSION
var primaryColor = Colors.blueGrey[800]!;
var secondaryColor = const Color(0xFF2A2D3E);
var bgColor = const Color(0xFF212332);
var defaultPadding = 16.0;

var dangerColor = Colors.red[300]!;
var successColor = Colors.green[300]!;
var infoColor = Colors.blue[300]!;
var warningColor = Colors.orange[300]!;
var disabledColor = Colors.grey[300]!;

var disabledTextColor = Colors.grey[800];
//--------

//Header size
const double h1 = 36;
const double h2 = 30;
const double h3 = 24;
const double h4 = 20;
const double h5 = 16;
const double h6 = 14;

//Font size
const double fs1 = 36;
const double fs2 = 30;
const double fs3 = 24;
const double fs4 = 20;
const double fs5 = 16;
const double fs6 = 14;

//---
const defaultRadius = 20;
//---

//Text
Color textColor1 = Colors.grey[700]!;
Color textColor2 = Colors.grey[600]!;
Color textColor3 = Colors.grey[500]!;
Color textColor4 = Colors.grey[500]!;
Color textColor5 = Colors.grey[300]!;
Color textColor6 = Colors.grey[200]!;

//Icon
Color iconColor1 = Colors.grey[700]!;
Color iconColor2 = Colors.grey[600]!;
Color iconColor3 = Colors.grey[500]!;
Color iconColor4 = Colors.grey[500]!;
Color iconColor5 = Colors.grey[300]!;
Color iconColor6 = Colors.grey[200]!;

//Height
const double hxs = 30;
const double hsm = 40;
const double hmd = 50;
const double hlg = 60;
const double hxl = 70;

//Width
const double wxs = 30;
const double wsm = 40;
const double wmd = 50;
const double wlg = 60;
const double wxl = 70;

//Width
double get w100 {
  return MediaQuery.of(Get.context!).size.width;
}

double get w90 {
  return MediaQuery.of(Get.context!).size.width * 0.9;
}

double get w80 {
  return MediaQuery.of(Get.context!).size.width * 0.8;
}

double get w70 {
  return MediaQuery.of(Get.context!).size.width * 0.7;
}

double get w60 {
  return MediaQuery.of(Get.context!).size.width * 0.6;
}

double get w50 {
  return MediaQuery.of(Get.context!).size.width * 0.5;
}

double get w40 {
  return MediaQuery.of(Get.context!).size.width * 0.4;
}

double get w30 {
  return MediaQuery.of(Get.context!).size.width * 0.3;
}

double get w20 {
  return MediaQuery.of(Get.context!).size.width * 0.2;
}

double get w10 {
  return MediaQuery.of(Get.context!).size.width * 0.1;
}

//Radius
const double rxs = 6;
const double rsm = 12;
const double rmd = 20;
const double rlg = 30;
const double rxl = 40;

//Color
Color appbarBackgroundColor = Colors.white;
Color scaffoldBackgroundColor = Colors.grey[300]!;
MaterialColor primarySwatch = Colors.blueGrey;
TextStyle googleFont = const TextStyle();
Color drawerBackgroundColor = const Color(0xff404E67);

//drawer
Color drawerFontColor = Colors.grey[300]!;

double cardElevation = 0.8;
double cardBorderRadius = 24.0;

class MainTheme {}

ThemeData getDefaultTheme() {
  return ThemeData(
    // primarySwatch:  Color(0xffFA533C),
    primaryColor: primaryColor,
    primarySwatch: primarySwatch,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(64.0),
        ),
        foregroundColor: Colors.white,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: appbarBackgroundColor,
      elevation: 0.6,
      titleTextStyle: googleFont.copyWith(
        color: Colors.blueGrey[700],
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.blueGrey[700],
      ),
    ),
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    drawerTheme: DrawerThemeData(
      backgroundColor: drawerBackgroundColor,
    ),
    iconTheme: IconThemeData(
      color: textColor1,
    ),
    textTheme: TextTheme(
      bodyLarge: googleFont.copyWith(color: textColor1),
      bodyMedium: googleFont.copyWith(color: textColor1),
    ),
    cardTheme: CardTheme(
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
    ),
    chipTheme: const ChipThemeData(),
    tabBarTheme: TabBarTheme(
      labelColor: textColor1,
    ),
  );
}

ThemeData getDarkTheme() {
  return ThemeData.dark().copyWith(
    // primarySwatch:  Color(0xffFA533C),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     shape: ContinuousRectangleBorder(
    //       borderRadius: BorderRadius.circular(64.0),
    //     ),
    //     foregroundColor: Colors.white,
    //   ),
    // ),
    // appBarTheme: AppBarTheme(
    //   backgroundColor: appbarBackgroundColor,
    //   elevation: 0.6,
    //   titleTextStyle: googleFont.copyWith(
    //     color: Colors.blueGrey[700],
    //     fontWeight: FontWeight.bold,
    //   ),
    //   iconTheme: IconThemeData(
    //     color: Colors.blueGrey[700],
    //   ),
    // ),
    // scaffoldBackgroundColor: scaffoldBackgroundColor,
    // drawerTheme: DrawerThemeData(
    //   backgroundColor: drawerBackgroundColor,
    // ),
    // iconTheme: IconThemeData(
    //   color: fontColor,
    // ),
    // textTheme: TextTheme(
    //   bodyText1: googleFont.copyWith(
    //     color: fontColor,
    //   ),
    //   bodyText2: googleFont.copyWith(
    //     color: fontColor,
    //   ),
    // ),
    cardTheme: CardTheme(
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
    ),
    // chipTheme: const ChipThemeData(),
    // tabBarTheme: TabBarTheme(
    //   labelColor: fontColor,
    // ),
  );
}

ThemeData getElegantTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: const Color(0xff212332),
    // primarySwatch:  Color(0xffFA533C),
    canvasColor: const Color(0xff26354F),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     shape: ContinuousRectangleBorder(
    //       borderRadius: BorderRadius.circular(64.0),
    //     ),
    //     foregroundColor: Colors.white,
    //   ),
    // ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xff212332),
      elevation: 0.6,
      titleTextStyle: TextStyle(
        color: Colors.blueGrey[700],
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xff2A2D3E),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      // backgroundColor: Color(0xff26354F),
      backgroundColor: Colors.red,
    ),
    // drawerTheme: DrawerThemeData(
    //   backgroundColor: drawerBackgroundColor,
    // ),
    // iconTheme: IconThemeData(
    //   color: fontColor,
    // ),
    textTheme: TextTheme(
      bodyLarge: googleFont.copyWith(color: Colors.white),
      bodyMedium: googleFont.copyWith(color: Colors.white),
    ),
    cardTheme: CardTheme(
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
    ),
    // chipTheme: const ChipThemeData(),
    // tabBarTheme: TabBarTheme(
    //   labelColor: fontColor,
    // ),
  );
}

ThemeData getOrangeTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: Colors.orange[800],
    // primarySwatch:  Color(0xffFA533C),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     shape: ContinuousRectangleBorder(
    //       borderRadius: BorderRadius.circular(64.0),
    //     ),
    //     foregroundColor: Colors.white,
    //   ),
    // ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xff06283D),
      elevation: 0.6,
      titleTextStyle: TextStyle(
        color: Colors.blueGrey[700],
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.blueGrey[700],
      ),
    ),
    scaffoldBackgroundColor: const Color(0xff256D85),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      // backgroundColor: Color(0xff26354F),
      backgroundColor: Colors.red,
    ),
    // drawerTheme: DrawerThemeData(
    //   backgroundColor: drawerBackgroundColor,
    // ),
    // iconTheme: IconThemeData(
    //   color: fontColor,
    // ),
    // textTheme: TextTheme(
    //   bodyText1: googleFont.copyWith(color: fontColor),
    //   bodyText2: googleFont.copyWith(color: fontColor),
    // ),
    cardTheme: CardTheme(
      color: const Color(0xff47B5FF),
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
    ),
    // chipTheme: const ChipThemeData(),
    // tabBarTheme: TabBarTheme(
    //   labelColor: fontColor,
    // ),
  );
}
