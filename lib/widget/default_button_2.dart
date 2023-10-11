import 'package:flutter/material.dart';

import '../config/constant.dart';

class DefaultButton2 extends StatelessWidget {
  const DefaultButton2({
    Key? key,
    required this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MaterialButton(
        color: kPrimaryColorRouge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'bold',
            fontSize: sizeText,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
