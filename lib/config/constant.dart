import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const kPrimaryColorBleu = Color.fromARGB(255, 11, 91, 196);
const kPrimaryColorBleuDark = Color.fromARGB(255, 9, 71, 151);
const kPrimaryColorBleuTrans1 = Color.fromARGB(206, 14, 46, 86);
const kPrimaryColorBleuTrans2 = Color.fromARGB(125, 14, 46, 86);
const kPrimaryColorRouge = Color.fromARGB(255, 132, 7, 68);
const kPrimaryColorRougeTransp1 = Color.fromARGB(199, 255, 48, 79);

const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryLightColor2 = Color(0xFFfff7f1);
const backgroundGris = Color.fromARGB(17, 20, 20, 19);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF554E84), Color(0xFF6e4e84)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kColorBackground = Color(0xFFF0F0F0);

const kColorOrange = Color(0xFFCCFFFF);

const double sizeText = 14;
const double sizeSmallText = 10;
const double sizeBigText = 22;
const double size15 = 15;
const double size18 = 18;

const kAnimationDuration = Duration(milliseconds: 200);

const defaultDuration = Duration(milliseconds: 250);

// Form Error  RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
final RegExp emailValidatorRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
const String kInvalidEmailError = "Veuillez entrer un e-mail valide";
const String kPassNullError = "S'il vous plait entrez votre mot de passe";
const String kShortPassError =
    "Le mot de passe est trop court\n8 carractères minimun";
const String kMatchPassError = "Les mots de passe ne correspondent pas";
const String kNamelNullError = "S'il vous plaît entrez votre nom";
const String kPhoneNumberNullError =
    "Veuillez entrer votre numéro de téléphone";
const String kAddressNullError = "Veuillez entrer votre adresse";

const String kPhoneNullError = "Entrez le numero de téléphone";
const String kBeneficiaryNameNullError = "Entrez le nom du bénéficiaire";
const String kMontantNullError = "Entrez le montant";
const String kAccountBankNullError = "Entrez le numero du compte";
const String kAccountBankErrorSize =
    "Le numero du compte doit avoir 23 chiffres";
const String kAccountBankErrorCompare = "Le numero de carte ne correspond pas";
const String kValeurNullError = "Renseignez cette information";
const String kNomNullError = "Renseignez le nom";
const String kPrenomNullError = "Renseignez le prenom";
const String kVilleNullError = "Renseignez la ville";
const String kPasswordNotEqual = "Le mot de passe ne correspond pas";
const String kInvalidPhoneError = "Numero non valide (9 chiffres recommandé)";
const String kCharactarError =
    "Symbole non recommandé ( ,." "_!#&*()+=|<>?{}[]~ )";

const String kInvalideEmailError = "Adresse mail non valide";
const String kCodeNullError = "Entrez votre code";
const String kCodeConfirmError = "Confirmez votre code";
const String kShortCodeError = "Le code doit être à 4 chiffres";
const String kShortCodeReapetError = "Le mot de passe ne correpond pas";
const String kMactchCodeError = "Le code ne correspond pas";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}

ThemeData themeData = ThemeData(
    primarySwatch: Colors.grey,
    primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)));

const degrade_linearGradient_colors_theme = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.1, 0.4, 0.7, 0.9],
  colors: [
    Color(color_theme_3),
    Color(color_theme_2),
    Color(color_theme_1),
    Color(color_theme_0),
  ],
);

const color_theme_0 = 0xFF36376D;
const color_theme_1 = 0xFF383b6E;
const color_theme_2 = 0xFF554E84;
const color_theme_3 = 0xFF6e4e84;

const color_box_decoration = 0xFFe8f1ff;

MaskTextInputFormatter maskPhoneFormatter =
    MaskTextInputFormatter(mask: '# ## ## ## ##');

MaskTextInputFormatter maskMontantFormatter =
    new MaskTextInputFormatter(mask: '### ### ###');

const int successHttpCode = 200;
const int successCinetPayCode = 201;
