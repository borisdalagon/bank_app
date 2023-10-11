import 'dart:convert';
import 'dart:developer';

import 'package:bank_app/model/account/create/response/create_account_response_model.dart';
import 'package:bank_app/model/account/create/response/error_register.dart';
import 'package:http/http.dart' as http;
import 'package:bank_app/config/constant.dart';
import 'package:bank_app/model/account/create/request/create_account_request_model.dart';
import 'package:bank_app/modules/login/login_screen.dart';
import 'package:bank_app/services/Urls.dart';
import 'package:bank_app/services/account_service.dart';
import 'package:bank_app/widget/custom_surffix_icon.dart';
import 'package:bank_app/widget/default_button_1.dart';
import 'package:bank_app/widget/default_button_3.dart';
import 'package:bank_app/widget/ra_text_field.dart';
import 'package:bank_app/widget/validator_email.dart';
import 'package:bank_app/widget/validator_name.dart';
import 'package:bank_app/widget/validator_password.dart';
import 'package:bottom_loader/bottom_loader.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int currentStep = 0;
  bool lastField = false;
  bool firstField = true;

  bool loader = false;

  String? valueNom = "";
  String? valuePrenom = "";
  String? valuePhone = "";
  String? valueEmail = "";
  String? valuePassword1 = "";
  String? valuePassword2 = "";
  bool firstCheck = false;
  bool firstCheck1 = false;
  bool firstCheck2 = false;

  late BottomLoader bl;
  final nameTextFieldController = TextEditingController();
  final lastNameTextFieldController = TextEditingController();
  final mailTextFieldController = TextEditingController();
  final mailRecuperationTextFieldController = TextEditingController();
  final passwordTextFieldController = TextEditingController();
  final passwordConfirmationTextFieldController = TextEditingController();
  Country? _countrySelected;
  bool changeCountry = false;

  final Duration initialDelay = Duration(seconds: 1);

  _countryPickerDropdown(bool filtered) => Row(
        children: <Widget>[
          Flexible(
            child: CountryPickerDropdown(
              initialValue: 'CM',
              itemBuilder: _buildDropdownItem,
              itemFilter: filtered
                  ? (c) => ['CM', 'DE', 'GB', 'CN'].contains(c.isoCode)
                  : null,
              onValuePicked: (Country? country) {
                if (kDebugMode) {
                  print("${country?.name}");
                }

                setState(() {
                  _countrySelected = country;
                  changeCountry = true;
                  print(_countrySelected!.phoneCode.toString());
                });
              },
            ),
          )
        ],
      );

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            Container(
              width: 25,
              height: 20,
              child: CountryPickerUtils.getDefaultFlagImage(country),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              country.currencyCode!,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    bl = BottomLoader(context, showLogs: true, isDismissible: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("INSCRIPTION"),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    DelayedDisplay(
                      delay: Duration(microseconds: 300),
                      child: Text(
                        "Inscrivez vous",
                        style: TextStyle(
                          fontFamily: 'extraBold',
                          color: Colors.blue,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Material(
                      child: Stepper(
                        steps: getSteps(),
                        physics: ClampingScrollPhysics(),
                        currentStep: currentStep,
                        onStepCancel: () {
                          // currentStep > 0 ? setState(() => currentStep -= 1) : null;

                          currentStep < 3
                              ? setState(() {
                                  if (currentStep != 0) {
                                    if (currentStep == 2) {
                                      lastField = false;
                                      firstField = false;
                                      currentStep -= 1;
                                    } else {
                                      lastField = false;
                                      firstField = true;
                                      currentStep -= 1;
                                    }
                                  }
                                })
                              : null;
                        },
                        onStepContinue: () {
                          currentStep < 2
                              ? setState(() {
                                  if (currentStep == 2) {
                                    lastField = true;
                                    firstField = false;
                                    currentStep += 1;
                                  } else if (currentStep == 1) {
                                    firstCheck2 = true;
                                    if (EmailFieldValidator.validate(
                                            valueEmail, context) ==
                                        null) {
                                      firstField = false;
                                      lastField = true;
                                      currentStep += 1;
                                    }
                                  } else if (currentStep == 0) {
                                    firstCheck1 = true;
                                    if (NameFieldValidator.validateNom(
                                                valueNom, context) ==
                                            null &&
                                        NameFieldValidator.validatePrenom(
                                                valuePrenom, context) ==
                                            null) {
                                      firstField = false;
                                      lastField = false;
                                      currentStep += 1;
                                    }
                                  }
                                })
                              : null;
                        },
                        controlsBuilder: (context, details) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: lastField
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Center(
                                          child: Text(
                                            "En vous inscrivant, vous acceptez les",
                                            style: TextStyle(
                                              fontSize: sizeSmallText,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "conditions d'utilisation",
                                            style: TextStyle(
                                                fontSize: sizeSmallText,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                            " de l'application et sa",
                                            style: TextStyle(
                                              fontSize: sizeSmallText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "politique de confidentialité,",
                                            style: TextStyle(
                                                fontSize: sizeSmallText,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                            " et confirmez",
                                            style: TextStyle(
                                              fontSize: sizeSmallText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Center(
                                          child: Text(
                                            "que vous vous inscrivez de votre propre et unique initiative.",
                                            style: TextStyle(
                                              fontSize: sizeSmallText,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      DefaultButton1(
                                        text: " SUIVANT ",
                                        press: () async {
                                          setState(() {
                                            firstCheck = true;
                                          });

                                          if (NameFieldValidator
                                                      .validateNom(
                                                          valueNom, context) ==
                                                  null &&
                                              NameFieldValidator.validatePrenom(
                                                      valuePrenom, context) ==
                                                  null &&
                                              EmailFieldValidator.validate(
                                                      valueEmail, context) ==
                                                  null &&
                                              PasswordFieldValidator.validate(
                                                      valuePassword1,
                                                      context) ==
                                                  null &&
                                              PasswordFieldValidator.compare(
                                                      valuePassword1,
                                                      valuePassword2,
                                                      context) ==
                                                  null) {
                                            CreateAccountRequestModel user =
                                                CreateAccountRequestModel();
                                            user.name =
                                                nameTextFieldController.text +
                                                    " " +
                                                    lastNameTextFieldController
                                                        .text;

                                            user.password =
                                                passwordTextFieldController
                                                    .text;
                                            user.currency = changeCountry ==
                                                    true
                                                ? _countrySelected!.currencyCode
                                                : "XAF";
                                            user.email = mailTextFieldController
                                                .text
                                                .replaceAll(" ", "");

                                            setState(() {
                                              loader = true;
                                            });
                                            createAccountRequest2(
                                                user, context);
                                          } else {
                                            Fluttertoast.showToast(
                                              backgroundColor: Colors.red,
                                              msg:
                                                  "Certaines imformations sont mal renseignées.\nVerifiez s'il vous plait",
                                            );
                                          }
                                        },
                                      ),
                                      TextButton(
                                          onPressed: details.onStepCancel,
                                          child: Text(
                                            "RETOUR",
                                            style: TextStyle(
                                                color: kPrimaryColorRouge,
                                                fontFamily: 'bold',
                                                fontSize: sizeText),
                                          ))
                                    ],
                                  )
                                : firstField
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DefaultButton3(
                                            text: " SUIVANT ",
                                            press: details.onStepContinue,
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          DefaultButton3(
                                            text: " SUIVANT ",
                                            press: details.onStepContinue,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          TextButton(
                                              onPressed: details.onStepCancel,
                                              child: Text(
                                                "RETOUR",
                                                style: TextStyle(
                                                    color: kPrimaryColorRouge,
                                                    fontFamily: 'bold',
                                                    fontSize: sizeText),
                                              ))
                                        ],
                                      ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            loader == true
                ? Container(
                    color: Colors.black54,
                    child: Center(
                      child: SpinKitCircle(
                        color: Colors.white,
                        size: 90,
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }

  List<Step> getSteps() {
    return [
      Step(
        title: new Text(
          "Informations personnelles",
          style: TextStyle(
              fontFamily: 'regular', fontSize: sizeText, color: Colors.black87),
        ),
        content: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            RATextField(
              controller: nameTextFieldController,
              surfix: Icons.person,
              label: "Nom (*)",
              hint: "Nom",
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) {
                setState(() {
                  valueNom = value;
                });
              },
              errorText: firstCheck1 && valueNom != null
                  ? NameFieldValidator.validateNom(valueNom, context)
                  : null,
            ),
            Container(
              width: double.infinity,
              child: Text(
                "Merci de renseigner l'intégralité de votre nom que resengné dans votre acte de naissance",
                style: TextStyle(fontSize: sizeSmallText),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RATextField(
              controller: lastNameTextFieldController,
              surfix: Icons.person,
              label: "Prenom (*)",
              hint: "Prenom",
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) {
                setState(() {
                  valuePrenom = value;
                });
              },
              errorText: firstCheck1 && valuePrenom != null
                  ? NameFieldValidator.validatePrenom(valuePrenom, context)
                  : null,
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              width: double.infinity,
              child: Text(
                "Selectionnez le pays à partir duquel vous allez effectuer vos transactions",
                style: TextStyle(fontSize: sizeSmallText),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        isActive: currentStep >= 0,
        state: currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: new Text(
          "Adresse mail details",
          style: TextStyle(
              fontFamily: 'regular', fontSize: sizeText, color: Colors.black87),
        ),
        content: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            RATextField(
              controller: mailTextFieldController,
              surfix: Icons.mail,
              label: "Adresse mail (*)",
              hint: "Adresse mail",
              onChanged: (value) {
                setState(() {
                  valueEmail = value;
                });
              },
              errorText: firstCheck2 && valueEmail != null
                  ? EmailFieldValidator.validate(valueEmail, context)
                  : null,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.white,
              child: _countryPickerDropdown(true),
            )
            // RATextField(
            //   controller: mailRecuperationTextFieldController,
            //   surfix: Icons.mail,
            //   label: "Adresse mail de récupération",
            //   hint: "Email de recuperation",
            //   validators: [Validator.isRequired],
            // ),
            // Container(
            //   width: double.infinity,
            //   child: Text(
            //     "Renseigner cette information si vous en disposé",
            //     style: TextStyle(fontSize: sizeSmallText),
            //   ),
            // ),
          ],
        ),
        isActive: currentStep >= 1,
        state: currentStep == 1
            ? StepState.editing
            : currentStep < 1
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: new Text(
          "Confidentialité",
          style: TextStyle(
              fontFamily: 'regular', fontSize: sizeText, color: Colors.black87),
        ),
        content: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            RATextField(
              controller: passwordTextFieldController,
              surfix: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
              label: "Mot de passe (*)",
              hint: "* * * * * * * * *",
              isPassword: true,
              onChanged: (value) {
                setState(() {
                  valuePassword1 = value;
                });
              },
              errorText: firstCheck && valuePassword1 != null
                  ? PasswordFieldValidator.validate(valuePassword1, context)
                  : null,
            ),
            SizedBox(
              height: 15,
            ),
            RATextField(
              controller: passwordConfirmationTextFieldController,
              surfix: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
              label: "Confirmer mot de passe (*)",
              hint: "* * * * * * * * *",
              isPassword: true,
              onChanged: (value) {
                setState(() {
                  valuePassword2 = value;
                });
              },
              errorText:
                  firstCheck && valuePassword1 != null && valuePassword2 != null
                      ? PasswordFieldValidator.compare(
                          valuePassword1, valuePassword2, context)
                      : null,
            ),
          ],
        ),
        isActive: currentStep >= 2,
        state: currentStep == 2
            ? StepState.editing
            : currentStep < 2
                ? StepState.disabled
                : StepState.complete,
      ),
    ];
  }

  /// Method to create new account
  Future<void> createAccountRequest2(
      CreateAccountRequestModel user, BuildContext context) async {
    log("--> ${Urls.ROOT_URI}${Urls.REGISTER_URL}");
    String GSONcreateAccountRequest = jsonEncode(user.toJson());
    print(GSONcreateAccountRequest);
    var body;

    createAccountResponse = null;
    if (createAccountResponse == null) {
      try {
        final response = await http.post(
          Uri.parse(Urls.ROOT_URI + Urls.REGISTER_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: GSONcreateAccountRequest,
        );

        int statusCode = response.statusCode;

        log('$statusCode');
        log('$response');
        body = json.decode(response.body);
        log('$body');
        createAccountResponse = CreateAccountResponseModel.fromJson(body);

        if (createAccountResponse!.user!.id != null) {
          Fluttertoast.showToast(
              msg: "Utilisateur crée avec succès",
              backgroundColor: Colors.green);

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));

          setState(() {
            loader = false;
          });
        }
      } catch (e) {
        if (body != null) {
          ErrorRegister errorRegister = ErrorRegister.fromJson(body);
          Future.delayed(const Duration(seconds: 1)).whenComplete(() {
            setState(() {
              loader = false;
            });
            Fluttertoast.showToast(
                msg: errorRegister.message!, backgroundColor: Colors.red);
            log("Exception: $e");
          });
        } else {
          Future.delayed(const Duration(seconds: 1)).whenComplete(() {
            setState(() {
              loader = false;
            });
            Fluttertoast.showToast(
                msg: "Impossible de se connecter au serveur");
            log("Exception: $e");
          });
        }
      }
    }
  }
}
