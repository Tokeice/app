import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_nm/type/Direction.dart';
import 'package:flutter_svg/svg.dart';

class SpeechBubble extends StatelessWidget {
  const SpeechBubble({
    super.key,
    required this.direction,
    required this.text,
  });

  final Direction direction;
  final String text;

  /// 吹き出し
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double scaleX = 1.0;
    double scaleY = 1.0;
    switch (direction) {
      case Direction.top:
      case Direction.bottom:
        scaleX = 1.0;
        scaleY = 1.3;
        break;
      case Direction.left:
      case Direction.right:
        scaleX = 1.4;
        scaleY = 1.0;
        break;
    }

    return Center(
        child: Stack(alignment: Alignment.center, children: [
      Transform.scale(
        scaleX: scaleX,
        scaleY: scaleY,
        child: SvgPicture.asset(
          'images/speech_bubble.svg',
        ),
      ),
      SizedBox(
        width: screenWidth * 0.7,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth * 0.08,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]));
  }
}