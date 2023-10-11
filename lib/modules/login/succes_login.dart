import 'dart:async';

import 'package:bank_app/config/config.dart';
import 'package:bank_app/modules/acceuil/acceuil.dart';
import 'package:bank_app/widget/default_button_1.dart';
import 'package:flutter/material.dart';

class LoginSuccessScreen extends StatefulWidget {
  LoginSuccessScreen(
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
  State<LoginSuccessScreen> createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (t) {
      t.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AcceuilScreen(
                nomComplet: widget.nomComplet,
                email: widget.email,
                token: widget.token,
                curency: widget.curency,
              )));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          height: 350,
          child: Image.asset("assets/animations/succes_transaction.gif"),
        ),
      ),
    );
  }
}
