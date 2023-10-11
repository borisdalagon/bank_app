import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../config/constant.dart';

class DefaultButton1 extends StatelessWidget {
  DefaultButton1({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  Function() press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Bounceable(
        onTap: press,
        child: Container(
          height: 58,
          child: Card(
            color: kPrimaryColorBleu,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: sizeText,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
