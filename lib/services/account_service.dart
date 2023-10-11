import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bank_app/model/account/create/request/create_account_request_model.dart';
import 'package:bank_app/model/account/create/response/create_account_response_model.dart';
import 'package:bottom_loader/bottom_loader.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../config/constant.dart';
import '../data/shared_pref_manager.dart';

import '../modules/login/login_screen.dart';
import '../modules/login/login_screen_body.dart';

import 'Urls.dart';

CreateAccountResponseModel? createAccountResponse;

class AccountService {
  var client = http.Client();
  var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  late BottomLoader bl;

  /// Method to create new account
  Future<void> createAccountRequest(
      CreateAccountRequestModel user, BuildContext context) async {
    bl = BottomLoader(context, showLogs: true, isDismissible: false);
    bl.style(
      message: "Veuillez patienter SVP",
      progressWidget:
          const SpinKitChasingDots(size: 50.0, color: kPrimaryColorBleu),
      messageTextStyle:
          const TextStyle(fontFamily: "regular", fontSize: size15),
    );
    bl.display();

    String GSONcreateAccountRequest = jsonEncode(user.toJson());
    print(GSONcreateAccountRequest);

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

        print(Urls.ROOT_URI + Urls.REGISTER_URL);

        int statusCode = response.statusCode;
        var body = json.decode(response.body);
        if (kDebugMode) {
          print(Urls.ROOT_URI + Urls.REGISTER_URL);
          print(body);

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        }
        createAccountResponse = CreateAccountResponseModel.fromJson(body);
        if (statusCode == successHttpCode) {
          bl.close();
        } else {
          bl.close();
          Fluttertoast.showToast(msg: "Un problème est survenu:");
        }
      } catch (e) {
        Future.delayed(const Duration(seconds: 1)).whenComplete(() {
          bl.close();
          Fluttertoast.showToast(msg: "Impossible de se connecter au serveur");
          log("Exception: $e");
        });
      }
    }
  }
}
