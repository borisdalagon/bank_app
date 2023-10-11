import 'package:flutter/material.dart';

/**
 * Class qui sera utilisé pour les test et pour afficher le contrôle 
 * du TextField du Montant
 */
class MontantFieldValidator {
  static String? validate(String? value, BuildContext context) {
    String? char;
    List listValue = value!.split("");
    List listSymbole = [
      ".",
      "_",
      "+",
      "-",
      "!",
      "#",
      "&",
      "*",
      "(",
      ")",
      "=",
      "|",
      "<",
      ">",
      "?",
      "{",
      "}",
      "[",
      "]",
      "~"
    ];
    for (int i = 0; i < listValue.length; i++) {
      char = value.characters.elementAt(i);
      for (int k = 0; k < listSymbole.length; k++) {
        if (char == listSymbole[k]) {
          return "Symbole non recommandé ( ,.\" \"_!#&*()+=|<>?{}[]~ )";
        }
      }
    }
    if (value.isEmpty) {
      return "Entrez le montant";
    }
    return null;
  }
}
