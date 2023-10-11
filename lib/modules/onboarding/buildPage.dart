import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../config/constant.dart';

class BuildPage extends StatelessWidget {
  const BuildPage({
    Key? key,
    required this.imageAsset,
    required this.titre,
    required this.descriptif,
  }) : super(key: key);
  final String imageAsset;
  final String titre;
  final String descriptif;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 10),
            height: 350,
            child: Image.asset(imageAsset),
          ),
          Text(
            titre,
            style: TextStyle(
              fontFamily: 'extraBold',
              color: kPrimaryColorBleu,
              fontSize: sizeBigText,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              textAlign: TextAlign.center,
              descriptif,
              style: TextStyle(),
            ),
          ),
        ],
      )),
    );
  }
}
