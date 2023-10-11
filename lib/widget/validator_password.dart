import 'package:flutter/material.dart';
import '../config/constant.dart';

/**
 * Class qui sera utilisé pour les test et pour afficher le contrôle 
 * du TextField du Montant
 */
class PasswordFieldValidator {
  static String? validate(String? value, BuildContext context) {
    String? char;

    if (value!.isEmpty) {
      return "S'il vous plait entrez votre mot de passe";
    } else if (value.length < 8) {
      return "Le mot de passe est trop court\n8 carractères minimun";
    }
    return null;
  }

  static String? compare(
      String? firstPassword, String? secondPassword, BuildContext context) {
    String? char;

    var result = firstPassword!.compareTo(secondPassword!);

    if (result == 0) {
      return null;
    } else {
      return "Le mot de passe ne correspond pas";
    }
  }
}
