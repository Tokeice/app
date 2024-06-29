import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Column(children: [
              Text(
                '00分00秒',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(0xFF, 0x41, 0x64, 0x98)),
              ),
              Text(
                '盛り上がりました！',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(0xFF, 0x14, 0x25, 0x40)),
              )
            ]),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: SvgPicture.asset('images/speech_bubble_result.svg',
                      width: screenWidth * 0.5),
                ),
                Container(
                  child: SvgPicture.asset(
                    'images/character_with_icecream.svg',
                    width: screenWidth * 0.5, // 画像の幅を画面幅の50%に指定
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                  SizedBox(
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        'images/button_back_to_title.svg',
                        width: screenWidth * 0.8,
                      ),
                    )
                  ),
                  Positioned(
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TitleScreen()),
                      );
                    },
                    child: Text(
                      'タイトルにもどる',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    )
                  )
            ])),
          )
        ],
      ),
    ));
  }
}
