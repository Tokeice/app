import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelfIntroCharacter extends StatelessWidget {
  const SelfIntroCharacter({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;
  
  @override
  Widget build(BuildContext context) {
    double speechWidth = screenWidth * 0.8;
    double characterWidth = screenWidth * 0.5;

    return Transform.translate(
        offset: Offset(0, screenWidth * 0.13),
        child: Column(
          children: [
            Stack( // 吹き出しと自己紹介を促すセリフを表示
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'images/speech_bubble_vertical_screen.svg',
                  width: speechWidth,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: speechWidth * 0.05),
                  width: speechWidth,
                  child: Text(
                    '君から順番に\n自己紹介して！',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.1,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              'images/character_normal.svg',
              width: characterWidth,
            ),
          ],
        ));
  }
}

