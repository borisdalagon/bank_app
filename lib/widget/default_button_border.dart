import 'package:flutter/material.dart';

import '../config/constant.dart';

class DefaultButtonBorderLine extends StatelessWidget {
  const DefaultButtonBorderLine({
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
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              width: 0,
              color: Colors.white,
              style: BorderStyle.solid,
            )),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onPressed: press,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontFamily: 'bold',
                fontSize: sizeText,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
