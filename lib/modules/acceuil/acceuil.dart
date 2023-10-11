import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:bank_app/model/account/logout/logout_model.dart';
import 'package:bank_app/model/account/user/userdetail.dart';
import 'package:bank_app/model/operations/credit/request/credit_request_model.dart';
import 'package:bank_app/model/operations/credit/response/credit_response_model.dart';
import 'package:bank_app/model/operations/debit/response/debit_error.dart';
import 'package:bank_app/modules/login/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:bank_app/config/constant.dart';
import 'package:bank_app/data/shared_pref_manager.dart';
import 'package:bank_app/model/account/authentication/response/error_login.dart';
import 'package:bank_app/model/operations/debit/request/debit_request_model.dart';
import 'package:bank_app/model/operations/debit/response/debit_response_model.dart';
import 'package:bank_app/services/Urls.dart';
import 'package:bank_app/widget/default_button_1.dart';
import 'package:bank_app/widget/ra_text_montant_acceuil.dart';
import 'package:bank_app/widget/validator_montant.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:elegant_radio_button_group/elegant_radio_button_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class AcceuilScreen extends StatefulWidget {
  AcceuilScreen(
      {Key? key,
      required this.nomComplet,
      required this.email,
      required this.token,
      required this.curency})
      : super(key: key);
  final String nomComplet;
  final String email;
  final String token;
  final String curency;

  @override
  State<AcceuilScreen> createState() => _AcceuilScreenState();
}

class _AcceuilScreenState extends State<AcceuilScreen> {
  UserSharedPrefManager userSharedPrefManager = UserSharedPrefManager();
  final montantTextFieldController = TextEditingController();
  final montantTextFieldController2 = TextEditingController();
  String? _userEmail;
  String? _userName;
  String? _userLastName;
  bool loader = false;

  String? balance;

  late int? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = 1;
    balanceRequest(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 280,
            width: double.infinity,
            color: kPrimaryColorBleu,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                _header(),
                _infoPerson()
              ],
            ),
          ),
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Material(
                    child: ListTile(
                      leading: ElegantRadioButton<int>(
                        groupValue: selectedValue,
                        value: 1,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        fillColor: MaterialStateProperty.all(Colors.red),
                      ),
                      title: const Text(
                        'Debitez votre compte',
                        style: TextStyle(
                            fontFamily: "bold",
                            color: Colors.black87,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  selectedValue == 1
                      ? Material(
                          child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              child: RATextMontantField(
                                editable: false,
                                controller: montantTextFieldController,
                                sizeHint: 20,
                                sizeLabel: 14,
                                sizeText: 20,
                                fontFamily: "bold",
                                testMontant: true,
                                colorText: Colors.black,
                                colorBackground: backgroundGris,
                                label:
                                    "Montant" + " ( " + widget.curency + " )",
                                hint: "00.00",
                                keyBoardType: TextInputType.number,
                                autoFocus: false,
                                onsubmited: (value) {
                                  /* userCheckStatusRequest(
                            widget.authenticateResponseModel!.data!.usrCode,
                            context);*/
                                },
                                errorText:
                                    montantTextFieldController.text != null
                                        ? MontantFieldValidator.validate(
                                            montantTextFieldController.text,
                                            context)
                                        : null,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 80, right: 180),
                              child: DefaultButton1(
                                text: "VALIDER",
                                press: () async {
                                  if (montantTextFieldController.text != "0" ||
                                      montantTextFieldController.text != "" ||
                                      montantTextFieldController.text != " " ||
                                      montantTextFieldController.text !=
                                          nullptr) {
                                    debitRequest(
                                        montantTextFieldController.text,
                                        widget.token,
                                        context);

                                    setState(() {
                                      loader = true;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ))
                      : Material(),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    child: ListTile(
                      leading: ElegantRadioButton<int>(
                        groupValue: selectedValue,
                        value: 2,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        fillColor:
                            MaterialStateProperty.all(const Color(0xFFFF9494)),
                      ),
                      title: const Text(
                        'Creditez votre compte',
                        style: TextStyle(
                            fontFamily: "bold",
                            color: Colors.black87,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  selectedValue == 2
                      ? Material(
                          child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              child: RATextMontantField(
                                editable: false,
                                controller: montantTextFieldController2,
                                sizeHint: 20,
                                sizeLabel: 14,
                                sizeText: 20,
                                fontFamily: "bold",
                                testMontant: true,
                                colorText: Colors.black,
                                colorBackground: backgroundGris,
                                label:
                                    "Montant" + " ( " + widget.curency + " )",
                                hint: "00.00",
                                keyBoardType: TextInputType.number,
                                autoFocus: false,
                                onsubmited: (value) {
                                  if (MontantFieldValidator.validate(
                                          montantTextFieldController2.text,
                                          context) ==
                                      null) {
                                    /* userCheckStatusRequest(
                            widget.authenticateResponseModel!.data!.usrCode,
                            context);*/
                                  }
                                },
                                errorText:
                                    montantTextFieldController2.text != null
                                        ? MontantFieldValidator.validate(
                                            montantTextFieldController2.text,
                                            context)
                                        : null,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 80, right: 180),
                              child: DefaultButton1(
                                text: "VALIDER",
                                press: () async {
                                  if (montantTextFieldController2.text != "0" ||
                                      montantTextFieldController2.text != "" ||
                                      montantTextFieldController2.text != " " ||
                                      montantTextFieldController2.text !=
                                          nullptr) {
                                    creditRequest(
                                        montantTextFieldController2.text,
                                        widget.token,
                                        context);

                                    setState(() {
                                      loader = true;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ))
                      : Material(),
                ],
              ),
              loader == true
                  ? FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                        height: (MediaQuery.of(context).size.height - 280),
                        color: Colors.black54,
                        child: Center(
                          child: SpinKitCircle(
                            color: Colors.white,
                            size: 90,
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }

  Container _infoPerson() {
    _userName = widget.nomComplet;
    _userEmail = widget.email;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 20, left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DelayedDisplay(
                delay: Duration(milliseconds: 500),
                child: Text(
                  _userName!,
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: 'bold'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 600),
                child: Text(
                  _userEmail!,
                  style: const TextStyle(
                      fontSize: 12, fontFamily: 'light', color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 700),
                child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        balance == null
                            ? CircularProgressIndicator()
                            : Text(
                                balance!,
                                style: TextStyle(
                                    fontFamily: 'extraBold',
                                    fontSize: 20,
                                    color: Colors.black87),
                              ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          widget.curency,
                          style: TextStyle(fontSize: 10, color: Colors.green),
                        )
                      ],
                    )),
              ),
            ],
          ),

          /* ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "assets/images/avatar_femme.png",
              height: 80,
              width: 80,
            )
          )*/
        ],
      ),
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Image.asset(
                "assets/images/logo_bank.png",
                width: 85,
                height: 85,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Bank App",
                style: TextStyle(
                    fontFamily: 'extraBold', fontSize: 26, color: Colors.white),
              ),
            ],
          ),
        ),
        Material(
            child: Container(
                padding: EdgeInsets.only(right: 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Dialogs.bottomMaterialDialog(
                              msg:
                                  'Etes-vous certains de vouloir faire cette opération ?',
                              title: 'Deconnexion',
                              context: context,
                              actions: [
                                IconsOutlineButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: 'Cancel',
                                  iconData: Icons.cancel_outlined,
                                  textStyle: TextStyle(color: Colors.grey),
                                  iconColor: Colors.grey,
                                ),
                                IconsButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  text: 'Se Deconnecter',
                                  iconData: Icons.logout,
                                  color: Colors.red,
                                  textStyle: TextStyle(color: Colors.white),
                                  iconColor: Colors.white,
                                ),
                              ]);
                        },
                        icon: Icon(Icons.logout)),
                    SizedBox(
                      width: 0,
                    )
                  ],
                ))),
      ],
    );
  }

  /// Method to debit
  Future<void> debitRequest(
      String montant, String token, BuildContext context) async {
    log("--> ${Urls.ROOT_URI}${Urls.DEBIT_ACCOUNT_URL}");

    DebitResponseModel? debitResponseModel = DebitResponseModel();

    DebitRequestModel debitRequestModel = DebitRequestModel();
    debitRequestModel.amount = int.parse(montant);

    String GSONdebitRequest = jsonEncode(debitRequestModel.toJson());
    var body;

    debitResponseModel = null;
    if (debitResponseModel == null) {
      try {
        final response = await http.post(
          Uri.parse(Urls.ROOT_URI + Urls.DEBIT_ACCOUNT_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: GSONdebitRequest,
        );

        int statusCode = response.statusCode;
        body = json.decode(response.body);
        log('$statusCode');
        if (kDebugMode) {
          print("<-- ${Urls.ROOT_URI}${Urls.DEBIT_ACCOUNT_URL}");
          print(body);

          debitResponseModel = DebitResponseModel.fromJson(body);
          if (debitResponseModel.accountJournal!.accountId! != null) {
            print("=========OK======OK======");
            Fluttertoast.showToast(
                msg: debitResponseModel.message!,
                backgroundColor: Colors.green);
            setState(() {
              loader = false;
              montantTextFieldController.text = "";
              balance =
                  debitResponseModel!.accountJournal!.balanceAfter!.toString();
            });
          } else {
            ErrorDebit errorDebit = ErrorDebit.fromJson(body);
            Fluttertoast.showToast(
                msg: errorDebit.message!, backgroundColor: Colors.red);
            setState(
              () {
                loader = false;
              },
            );
          }
        }
      } catch (e) {
        if (body != null) {
          ErrorDebit errorDebit = ErrorDebit.fromJson(body);
          Future.delayed(const Duration(seconds: 1)).whenComplete(() {
            Fluttertoast.showToast(
                msg: errorDebit.message!, backgroundColor: Colors.red);
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

  /// Method to credit
  Future<void> creditRequest(
      String montant, String token, BuildContext context) async {
    log("--> ${Urls.ROOT_URI}${Urls.CREDIT_ACCOUNT_URL}");

    CreditResponseModel? creditResponseModel = CreditResponseModel();

    CreditRequestModel creditRequestModel = CreditRequestModel();
    creditRequestModel.amount = int.parse(montant);

    String GSONdebitRequest = jsonEncode(creditRequestModel.toJson());
    var body;

    creditResponseModel = null;
    if (creditResponseModel == null) {
      try {
        final response = await http.post(
          Uri.parse(Urls.ROOT_URI + Urls.CREDIT_ACCOUNT_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: GSONdebitRequest,
        );

        int statusCode = response.statusCode;
        body = json.decode(response.body);
        log('$statusCode');
        if (kDebugMode) {
          print("<-- ${Urls.ROOT_URI}${Urls.CREDIT_ACCOUNT_URL}");
          print(body);

          creditResponseModel = CreditResponseModel.fromJson(body);
          if (creditResponseModel.accountJournal!.accountId! != null) {
            print("=========OK======OK======");
            Fluttertoast.showToast(
                msg: creditResponseModel.message!,
                backgroundColor: Colors.green);
            setState(() {
              loader = false;
              montantTextFieldController2.text = "";
              balance =
                  creditResponseModel!.accountJournal!.balanceAfter!.toString();
            });
          } else {
            ErrorDebit errorDebit = ErrorDebit.fromJson(body);
            Fluttertoast.showToast(
                msg: errorDebit.message!, backgroundColor: Colors.red);
            setState(
              () {
                loader = false;
              },
            );
          }
        }
      } catch (e) {
        if (body != null) {
          ErrorDebit errorDebit = ErrorDebit.fromJson(body);
          Future.delayed(const Duration(seconds: 1)).whenComplete(() {
            Fluttertoast.showToast(
                msg: errorDebit.message!, backgroundColor: Colors.red);
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

  /// Method to balance
  Future<void> balanceRequest(String token) async {
    log("--> ${Urls.ROOT_URI}${Urls.USER_DETAILS_URL}");

    UserDetailResponse? userDetailResponse = UserDetailResponse();

    var body;

    try {
      final response = await http.get(
        Uri.parse(Urls.ROOT_URI + Urls.USER_DETAILS_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      int statusCode = response.statusCode;
      body = json.decode(response.body);
      log('$statusCode');
      if (kDebugMode) {
        print("<-- ${Urls.ROOT_URI}${Urls.USER_DETAILS_URL}");
        print(body);

        userDetailResponse = UserDetailResponse.fromJson(body);
        if (userDetailResponse.user!.id! != null) {
          print("=========OK======OK======");

          setState(() {
            loader = false;
            balance = userDetailResponse!.user!.account!.balance!;
          });
        } else {
          ErrorDebit errorDebit = ErrorDebit.fromJson(body);
          Fluttertoast.showToast(
              msg: errorDebit.message!, backgroundColor: Colors.red);
          setState(
            () {
              loader = false;
            },
          );
        }
      }
    } catch (e) {
      if (body != null) {
        ErrorDebit errorDebit = ErrorDebit.fromJson(body);
        Future.delayed(const Duration(seconds: 1)).whenComplete(() {
          Fluttertoast.showToast(
              msg: errorDebit.message!, backgroundColor: Colors.red);
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

  /// Method to logout
  Future<void> logoutRequest(String token) async {
    log("--> ${Urls.ROOT_URI}${Urls.LOGOUT_URL}");

    LogoutResponseModel? logoutResponseModel = LogoutResponseModel();

    var body;

    try {
      final response = await http.get(
        Uri.parse(Urls.ROOT_URI + Urls.LOGOUT_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      int statusCode = response.statusCode;
      body = json.decode(response.body);
      log('$statusCode');
      if (kDebugMode) {
        print("<-- ${Urls.ROOT_URI}${Urls.USER_DETAILS_URL}");
        print(body);

        logoutResponseModel = LogoutResponseModel.fromJson(body);
        if (logoutResponseModel.message != null) {
          print("=========OK======OK======");

          setState(() {
            loader = false;
          });
        } else {
          ErrorDebit errorDebit = ErrorDebit.fromJson(body);
          Fluttertoast.showToast(
              msg: errorDebit.message!, backgroundColor: Colors.red);
          setState(
            () {
              loader = false;
            },
          );
        }
      }
    } catch (e) {
      if (body != null) {
        ErrorDebit errorDebit = ErrorDebit.fromJson(body);
        Future.delayed(const Duration(seconds: 1)).whenComplete(() {
          Fluttertoast.showToast(
              msg: errorDebit.message!, backgroundColor: Colors.red);
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
