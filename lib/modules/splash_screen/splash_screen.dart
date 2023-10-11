import 'package:bank_app/config/constant.dart';
import 'package:bank_app/modules/login/login_screen.dart';
import 'package:bank_app/modules/onboarding/onboarding_screen.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.showHome}) : super(key: key);
  final String showHome;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  final Duration initialDelay = Duration(seconds: 1);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(seconds: 10)).then((value) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (ctx) => widget.showHome.compareTo("OK") == 0
              ? LoginScreen()
              : OnboardingScreen()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("App Lifecycle State : $state");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DelayedDisplay(
                        delay: Duration(seconds: initialDelay.inSeconds + 1),
                        child: const Image(
                          image: AssetImage(
                            "assets/images/logo_bank.png",
                          ),
                          height: 180,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DelayedDisplay(
                        delay: Duration(seconds: initialDelay.inSeconds + 2),
                        child: const Text(
                          "Bank App",
                          style: TextStyle(
                            fontFamily: 'extraBold',
                            color: kPrimaryColorBleuDark,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      DelayedDisplay(
                        delay: Duration(seconds: initialDelay.inSeconds + 3),
                        child: const Text(
                          "Application de test",
                          style: TextStyle(
                              fontFamily: 'semibold',
                              color: kPrimaryColorRouge),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 0,
                  child: DelayedDisplay(
                    delay: Duration(seconds: initialDelay.inSeconds + 4),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: const SpinKitChasingDots(
                        color: kPrimaryColorBleuDark,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
