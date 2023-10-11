import 'dart:convert';
import 'dart:developer';

import 'package:bank_app/data/shared_pref_manager.dart';
import 'package:bank_app/model/account/authentication/response/error_login.dart';
import 'package:bank_app/modules/login/succes_login.dart';
import 'package:bank_app/widget/custom_surffix_icon.dart';
import 'package:bank_app/widget/validator_email.dart';
import 'package:bank_app/widget/validator_password.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:bank_app/model/account/authentication/request/authenticate_request_model.dart';
import 'package:bank_app/model/account/authentication/response/authenticate_response_model.dart';
import 'package:bank_app/widget/default_button_1.dart';
import 'package:bank_app/widget/ra_text_field.dart';
import 'package:bottom_loader/bottom_loader.dart';

import 'package:delayed_display/delayed_display.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:math' as math;

import '../../config/constant.dart';

import '../../services/Urls.dart';

AuthenticateResponseModel? authenticateResponse;
//BaseResponse? baseResponse;

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody>
    with AutomaticKeepAliveClientMixin<LoginScreenBody> {
  late BottomLoader bl;
  final mailTextFieldController = TextEditingController();
  final passwordTextFieldController = TextEditingController();
  final mailRecupTextFieldController = TextEditingController();

  final Duration initialDelay = const Duration(seconds: 1);

  bool loader = false;

  @override
  void initState() {
    super.initState();
    bl = BottomLoader(context, showLogs: true, isDismissible: true);
  }

  @override
  void dispose() {
    mailTextFieldController.dispose();
    passwordTextFieldController.dispose();
    super.dispose();
  }

  String? valuePassword = "";
  String? valueEmail = "";
  bool firstCheck = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
          height: height,
          width: width,
          color: Colors.blue.withOpacity(.05),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: DelayedDisplay(
                      delay: Duration(seconds: initialDelay.inSeconds + 1),
                      child: Image(
                        image: AssetImage(
                          "assets/images/logo_bank.png",
                        ),
                        height: 120,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: DelayedDisplay(
                      delay: Duration(seconds: initialDelay.inSeconds + 2),
                      child: Text(
                        "Bank App",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'extraBold',
                          color: kPrimaryColorBleu,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: DelayedDisplay(
                      delay: Duration(seconds: initialDelay.inSeconds + 3),
                      child: Text(
                        "Application de test",
                        style: TextStyle(
                            fontFamily: 'semibold',
                            color: kPrimaryColorRouge,
                            fontSize: 7),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "CONNECTEZ - VOUS",
                    style: TextStyle(
                      fontFamily: 'extraBold',
                      color: Colors.blue,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                      child: DelayedDisplay(
                          delay: Duration(milliseconds: 350),
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Card(
                                elevation: 4,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(14),
                                  color: kColorBackground,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Apres avoir renseigné votre adresse mail de recupération, un nouveau mot de passe vous sera envoyé dans votre boîte mail.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "light",
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      RATextField(
                                        keyBoardType:
                                            TextInputType.emailAddress,
                                        controller: mailTextFieldController,
                                        surfix: Icons.mail,
                                        fontText: 'bold',
                                        label: "Adresse mail",
                                        hint: "Email de recuperation",
                                        errorText:
                                            firstCheck && valueEmail != null
                                                ? EmailFieldValidator.validate(
                                                    valueEmail, context)
                                                : null,
                                        onChanged: (value) {
                                          setState(() {
                                            valueEmail = value;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RATextField(
                                        controller: passwordTextFieldController,
                                        fontText: 'bold',
                                        surfix: const CustomSurffixIcon(
                                            svgIcon: "assets/icons/Lock.svg"),
                                        label: "Mot de passe",
                                        hint: "Entrer votre mot de passe",
                                        isPassword: true,
                                        textInputAction: TextInputAction.done,
                                        onsubmited: (value) {},
                                        errorText: firstCheck &&
                                                valuePassword != null
                                            ? PasswordFieldValidator.validate(
                                                valuePassword, context)
                                            : null,
                                        onChanged: (value) {
                                          setState(() {
                                            valuePassword = value;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 30),
                                      DefaultButton1(
                                        text: "VALIDER",
                                        press: () async {
                                          onPressedLoginProgressButton();
                                        },
                                      ),
                                      /* Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: loginProgressButton(),
                                ),*/
                                      SizedBox(height: 0),
                                    ],
                                  ),
                                ),
                              ))))
                ],
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
          )),
    );
  }

  void onPressedLoginProgressButton() {
    if (EmailFieldValidator.validate(valueEmail, context) == null &&
        PasswordFieldValidator.validate(valuePassword, context) == null) {
      firstCheck = true;

      setState(() {
        loader = true;
      });
      authenticateRequest(mailTextFieldController.text,
          passwordTextFieldController.text, context);
    }

    setState(
      () {
        firstCheck = true;
      },
    );
  }

  /// Method to user authenticate
  Future<void> authenticateRequest(
      String? mail, String? password, BuildContext context) async {
    log("--> ${Urls.ROOT_URI}${Urls.LOGIN_URL}");

    AuthenticateRequestModel authenticateRequest = AuthenticateRequestModel();
    authenticateRequest.email = mail;
    authenticateRequest.password = password;
    String GSONauthenticateRequest = jsonEncode(authenticateRequest.toJson());
    var body;

    authenticateResponse = null;
    if (authenticateResponse == null) {
      try {
        final response = await http.post(
          Uri.parse(Urls.ROOT_URI + Urls.LOGIN_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: GSONauthenticateRequest,
        );

        int statusCode = response.statusCode;
        body = json.decode(response.body);
        log('$statusCode');
        if (kDebugMode) {
          print("<-- ${Urls.ROOT_URI}${Urls.LOGIN_URL}");
          print(body);

          authenticateResponse = AuthenticateResponseModel.fromJson(body);
          if (authenticateResponse!.authorization!.token != null) {
            print("=========OK======OK======");
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginSuccessScreen(
                      nomComplet: authenticateResponse!.user!.name!,
                      email: authenticateResponse!.user!.email!,
                      token: authenticateResponse!.authorization!.token!,
                      curency: authenticateResponse!.user!.currency!,
                    )));
            UserSharedPrefManager userSharedPrefManager =
                UserSharedPrefManager();
            userSharedPrefManager.setUserId(authenticateResponse!.user!.id!);
            userSharedPrefManager
                .setUserName(authenticateResponse!.user!.name!);
            userSharedPrefManager
                .setUserEmail(authenticateResponse!.user!.email!);

            print("====NAME === " + authenticateResponse!.user!.name!);
            print("====email === " + authenticateResponse!.user!.email!);

            setState(() {
              loader = false;
            });
          } else {
            ErrorLogin errorLogin = ErrorLogin.fromJson(body);
            Fluttertoast.showToast(
                msg: errorLogin.message!, backgroundColor: Colors.black);
            setState(
              () {
                loader = false;
              },
            );
          }
        }
      } catch (e) {
        ErrorLogin errorLogin = ErrorLogin.fromJson(body);

        if (body != null) {
          Future.delayed(const Duration(seconds: 1)).whenComplete(() {
            Fluttertoast.showToast(
                msg: errorLogin.message!, backgroundColor: Colors.red);
            setState(
              () {
                loader = false;
              },
            );
            log("Exception: $e");
          });
        } else {
          Future.delayed(const Duration(seconds: 1)).whenComplete(() {
            Fluttertoast.showToast(
                msg: "Impossible de se connecter au serveur",
                backgroundColor: Colors.black);
            setState(
              () {
                loader = false;
              },
            );
            log("Exception: $e");
          });
        }
      }
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
