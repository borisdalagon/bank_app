import 'package:bank_app/config/constant.dart';
import 'package:flutter/material.dart';

class Config {
  static final String devise = 'XAF';
  static final String essence = 'ESSENCE';
  static final String diesel = 'DIESEL';
  static final String gasoil = 'GASOIL';

  static final headingStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5,
  );

  /* static double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = Get.height;
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight;
  }

// Get the proportionate height as per screen size
  static double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = Get.width;
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth;
  } */

  static final assets = _Assets();
  static final colors = _Colors();
}

class _Assets {
  final car = "assets/icons/car3.svg";
  final mail = "assets/icons/Mail.svg";
  final b1 = "assets/images/b1.jpg";
  final b2 = "assets/images/b2.jpg";
  final b3 = "assets/images/b3.jpg";
  final l1 = "assets/images/logo1.png";
  final l2 = "assets/images/logo2.png";
  final l3 = "assets/images/logo3.png";
}

class _Colors {
  final primaryColor = kPrimaryColorBleu;
}
