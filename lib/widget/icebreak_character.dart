import 'package:flutter/material.dart';
import 'package:test_nm/widget/self_intro_arrow.dart';
import 'package:test_nm/widget/self_intro_character.dart';
import 'package:test_nm/widget/direction_character_speech_widget.dart';
import 'package:test_nm/type/Direction.dart';

class IcebreakCharacter extends StatelessWidget {
  const IcebreakCharacter({
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
    return DirectionCharacterSpeechWidget(
        direction: Direction.left, text: theme, screenWidth: screenWidth);
  }
}
