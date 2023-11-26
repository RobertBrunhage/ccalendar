import 'package:flutter/material.dart';

class Styles$Colors {
  Styles$Colors._();

  // transparent
  static const Color transparent = Colors.transparent;

  // black
  static const black100 = Color(0xFF141414);
  static const black70 = Color(0xB3000000);

  // grey
  static const grey100 = Color(0xFFF9F9F9);
  static const grey200 = Color(0xFFF4F4F4);
  static const grey300 = Color(0xFFF4F4F4);
  static const grey400 = Color(0xFFEEEEEE);
  static const grey500 = Color(0xFFE2E2E2);
  static const grey600 = Color(0xFF666666);

  // white
  static const white20 = Color(0x33FFFFFF);
  static const white70 = Color(0xB3FFFFFF);
  static const white100 = Color(0xFFFFFFFF);

  // yellow
  static const yellow600 = Colors.yellow;
}

class Styles$Texts {
  Styles$Texts._();

  /// fontsize: 12
  static const TextStyle xxsNormal = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Styles$Colors.black100,
  );

  /// fontsize: 14
  static const TextStyle xsNormal = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Styles$Colors.black100,
  );

  /// fontsize: 14 bold
  static const TextStyle xsMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Styles$Colors.black100,
  );

  /// fontsize: 16
  static const TextStyle smNormal = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Styles$Colors.black100,
  );

  /// fontsize: 16 bold
  static const TextStyle smMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Styles$Colors.black100,
  );

  /// fontsize: 18
  static const TextStyle baseNormal = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Styles$Colors.black100,
  );

  /// fontsize: 18 bold
  static const TextStyle baseMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Styles$Colors.black100,
  );


  /// fontsize: 22
  static const TextStyle xlNormal = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: Styles$Colors.black100,
  );

  /// fontsize: 22 bold
  static const TextStyle xlMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Styles$Colors.black100,
  );

  /// fontsize: 26
  static const TextStyle xxlNormal = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: Styles$Colors.black100,
  );

  /// fontsize: 21 bold
  static const TextStyle xxxlMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Styles$Colors.black100,
  );

  /// fontsize: 48
  static const TextStyle mega = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: Styles$Colors.black100,
  );
}

class Styles$Timings {
  Styles$Timings._();

  static const Duration superFast = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration base = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration superSlow = Duration(milliseconds: 1600);
}
