import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_nm/type/Direction.dart';
import 'package:flutter_svg/svg.dart';

/// キャラクターと吹き出し
/// direction: キャラクターの向き
/// text: 吹き出しのテキスト
class DirectionCharacterSpeechWidget extends StatelessWidget {
  const DirectionCharacterSpeechWidget({
    super.key,
    required this.direction,
    required this.text,
    required this.screenWidth,
  });

  final Direction direction;
  final String text;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    Alignment alignment;
    double angle = 0;
    double translateY = screenWidth * 0.173;

    switch (direction) {
      case Direction.top:
        alignment = Alignment.topCenter;
        angle = 3.14159;
        break;
      case Direction.bottom:
        alignment = Alignment.bottomCenter;
        angle = 0;
        break;
      case Direction.left:
        alignment = Alignment.centerRight;
        angle = 3.14159 / 2;
        break;
      case Direction.right:
        alignment = Alignment.centerLeft;
        angle = -3.14159 / 2;
        break;
    }

    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: Offset(0, translateY),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpeechBubbleWidget(direction: direction,text: text),
              if (direction == Direction.top || direction == Direction.bottom)
                SizedBox(height: screenWidth * 0.1),
              SvgPicture.asset(
                'images/character_normal.svg',
                width: screenWidth * 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpeechBubbleWidget extends StatelessWidget {
  const SpeechBubbleWidget({
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
