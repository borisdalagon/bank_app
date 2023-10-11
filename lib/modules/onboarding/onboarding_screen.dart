import 'package:bank_app/config/constant.dart';
import 'package:bank_app/modules/login/login_screen.dart';
import 'package:bank_app/modules/onboarding/buildPage.dart';
import 'package:bank_app/widget/default_button_1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with WidgetsBindingObserver {
  final controller = PageController();
  bool isLastPage = false;
  var page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    controller.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // super.didChangeAppLifecycleState(state)

    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        print("App Lifecycle State : $state");
        break;
      case AppLifecycleState.inactive:
        print("App Lifecycle State : $state");
        break;
      case AppLifecycleState.paused:
        onPaused();
        print("App Lifecycle State : $state");
        break;
      case AppLifecycleState.detached:
        print("App Lifecycle State : $state");
        onDetached();
        break;
    }
  }

  void onResumed() {
    // TODO: implement onResumed
  }
  void onPaused() {}

  void onInactive() {
    // TODO: implement onInactive
    AppLifecycleState.paused;
  }

  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
              page = index;
            });
          },
          children: [
            BuildPage(
              imageAsset: 'assets/animations/send_money.gif',
              titre: "Vos opération bancaires",
              descriptif:
                  "Bienvenu chez vous. Faites vos opérations bancaire en toute securité",
            ),
            BuildPage(
              imageAsset: 'assets/animations/welcome.gif',
              titre: "Creditez votre compte",
              descriptif:
                  "Avec notre application, vous pourriez crediter votre en toute securuté",
            ),
            BuildPage(
              imageAsset: 'assets/animations/payer_facture.gif',
              titre: "Debitez votre compte",
              descriptif:
                  "Nous vous offrons des solutions adéquates pour débitez votre compte en toute sécurité.",
            ),
          ]),
      bottomSheet: isLastPage
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              width: double.infinity,
              child: DefaultButton1(
                text: "Commencez",
                press: () async {
                  //share preference
                  print("===================");
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('showHome', "OK");

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            )
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 100,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/font.png',
                      width: double.infinity,
                    ),
                  ),
                  Column(
                    children: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.jumpToPage(2);
                          },
                          child: Icon(Icons.navigate_next, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: kPrimaryColorRouge, // <-- Button color
                            onPrimary: kPrimaryColorBleu, // <-- Splash color
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Center(
                              child: Container(
                            margin: EdgeInsets.only(top: 4),
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: 3,
                              effect: JumpingDotEffect(
                                activeDotColor: kPrimaryColorRouge,
                                dotHeight: 10,
                                dotWidth: 10,
                                jumpScale: .7,
                                verticalOffset: 15,
                              ),
                              onDotClicked: (index) => controller.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: (500)),
                                  curve: Curves.easeIn),
                            ),
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              page == 0
                                  ? TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "PRECEDENT",
                                        style: TextStyle(
                                            fontFamily: 'semibold',
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ))
                                  : TextButton(
                                      onPressed: () {
                                        controller.previousPage(
                                            duration: const Duration(
                                                milliseconds: (500)),
                                            curve: Curves.easeOut);
                                      },
                                      child: Text(
                                        "PRECEDENT",
                                        style: TextStyle(
                                            fontFamily: 'semibold',
                                            fontSize: 12),
                                      )),
                              TextButton(
                                  onPressed: () {
                                    controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: (500)),
                                        curve: Curves.easeInOut);
                                  },
                                  child: Text("SUIVANT",
                                      style: TextStyle(
                                          fontFamily: 'semibold',
                                          fontSize: 12))),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
