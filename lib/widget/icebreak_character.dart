import 'package:flutter/material.dart';
import 'package:test_nm/widget/direction_character_speech.dart';
import 'package:test_nm/type/Direction.dart';

class IceBreakCharacter extends StatelessWidget {
  const IceBreakCharacter({
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
    return DirectionCharacterSpeech(
      direction: Direction.left, text: theme, screenWidth: screenWidth, isActive: true
    );
  }
}