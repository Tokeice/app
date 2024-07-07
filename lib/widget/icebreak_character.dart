import 'package:flutter/material.dart';
import 'package:test_nm/widget/direction_character_speech.dart';
import 'package:test_nm/type/Direction.dart';

class IceBreakCharacter extends StatelessWidget {
  const IceBreakCharacter({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    String theme = "Loading...";

    // return Align(
    //   alignment: Alignment.bottomCenter,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       SelfIntroArrow(screenWidth: screenWidth),
    //       SelfIntroCharacter(screenWidth: screenWidth),
    //     ],
    //   ),
    // );
    // 以下のコードでキャラクターとトークテーマを表示
    return DirectionCharacterSpeech(
      direction: Direction.left, text: theme, screenWidth: screenWidth, isActive: true
    );
  }
}
