import 'package:bank_app/config/constant.dart';
import 'package:bank_app/modules/login/login_screen_body.dart';
import 'package:bank_app/modules/register/register.dart';
import 'package:bank_app/widget/default_button_2.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AutomaticKeepAliveClientMixin<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kColorBackground,
      appBar: null,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/jeune-homme.jpg',
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.white54,
            ),
            LoginScreenBody()
            /* CircularParticle(
              height: height,
              width: width,
              particleColor: Colors.white.withOpacity(.6),
              numberOfParticles: 150,
              speedOfParticles: 1.5,
              maxParticleSize: 7,
              awayRadius: 0,
              onTapAnimation: false,
              isRandSize: true,
              isRandomColor: false,
              connectDots: false,
              enableHover: false,
            ),
            CircularParticle(
              width: width,
              height: height,
              awayRadius: width / 5,
              numberOfParticles: 100,
              speedOfParticles: 1.5,
              maxParticleSize: 7,
              particleColor: Colors.white.withOpacity(.7),
              awayAnimationDuration: Duration(milliseconds: 200000),
              awayAnimationCurve: Curves.easeInOutBack,
              onTapAnimation: true,
              isRandSize: true,
              isRandomColor: false,
              connectDots: true,
              enableHover: true,
              hoverColor: Colors.black,
              hoverRadius: 90,
            ),*/
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 105,
        color: kColorBackground,
        child: Stack(
          children: [
            Container(
                alignment: Alignment.topRight,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/font2.png",
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        child: Text(
                      "Vous n'avez pas encore de compte ?",
                      style: TextStyle(color: Colors.black),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultButton2(
                      text: "     Inscrivez-vous ici     ",
                      press: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register()));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "By BJFT " +
                            "inc Copyright © 2023 " +
                            "Version " +
                            "1.0",
                        style: TextStyle(fontSize: 9),
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
