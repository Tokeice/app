import 'package:flutter/material.dart';
import 'package:test_nm/widget/self_intro_arrow.dart';
import 'package:test_nm/widget/self_intro_character.dart';
import 'package:test_nm/widget/direction_character_speech_widget.dart';
import 'package:test_nm/type/Direction.dart';

class IcebreakCharacter extends StatelessWidget{
  const IcebreakCharacter({
    super.key,
    required this.screenWidth,
    required this.theme,
    required this.direction,
  });

  final double screenWidth;
  final String theme;
  final Direction direction;

  @override
  Widget build(BuildContext context) {
    // 以下のコードでキャラクターとトークテーマを表示
    return DirectionCharacterSpeechWidget(
        direction: direction, text: theme, screenWidth: screenWidth);
  }
}
