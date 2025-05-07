import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  // Accent color (slider, indicator…)
  static const Color accent = Color(0xFF4B8E96);

  // Text chính – sáng
  static const Color textPrimaryLight = Color(0xFF1A1A1A);

  // Text phụ – sáng
  static const Color textSecondaryLight = Color(0xFF6E6E6E);

  // Text chính – tối
  static const Color textPrimaryDark = Colors.white;

  // Text phụ – tối
  static const Color textSecondaryDark = Color(0xFFB3B3B3);

  /// Ink Colors
  static const Color ink06 = Colors.white;
  static const Color ink05 = Color(0XFFE8EEF3);
  static const Color ink04 = Color(0XFFCDD9E3);
  static const Color ink03 = Color(0XFFACB8C2);
  static const Color ink02 = Color(0XFF656F77);
  static const Color ink01 = Color(0XFF191D21);

  /// Utility Colors
  static const Color active = Color(0XFF1814E4);
  static const Color info = Color(0XFF91D7E0);
  static const Color warning = Color(0XFFFFAC4B);
  static const Color dangerError = Color(0XFFFF5A5A);
  static const Color success = Color(0XFF23E9B4);
  static const Color darkBackground = Color(0XFF393939);

  /// Accent Colors
  static const Color orange = Color(0XFFFFC76F);
  static const Color lightBlue = Color(0XFFDBF2FF);
  static const Color green = Color(0XFFD8FFE5);
  static const Color blue = Color(0XFFA6B9FF);
  static const Color purple = Color(0XFFBBA5FF);
  static const Color pink = Color(0XFFFFE8EC);

  static final List<Color> placeHolderColors = [
    orange,
    lightBlue,
    green,
    blue,
    purple,
    pink,
  ];

  static Color getRandomPlaceHolderColor() {
    final random = Random();
    return placeHolderColors[random.nextInt(placeHolderColors.length)];
  }
}
