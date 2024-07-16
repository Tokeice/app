import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_nm/type/Direction.dart';
import 'direction_character_speech.dart';

/// キャラクターを上下左右に表示する
/// direction: キャラクターの向き
/// text: 吹き出しのテキスト
class CharacterSpeech extends StatefulWidget {
  final Direction direction;
  final String text;
  final double screenWidth;
  final bool isExcite;

  const CharacterSpeech({
    super.key,
    required this.direction,
    required this.text,
    required this.screenWidth,
    required this.isExcite,
  });
  
  @override
  CharacterSpeechState createState() => CharacterSpeechState();
}

class CharacterSpeechState extends State<CharacterSpeech> with SingleTickerProviderStateMixin {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DirectionCharacterSpeech(
          direction: Direction.top,
          text: widget.text,
          screenWidth: widget.screenWidth,
          isActive: widget.direction == Direction.top,
          isExcite: widget.isExcite,
        ),
        DirectionCharacterSpeech(
          direction: Direction.bottom,
          text: widget.text,
          screenWidth: widget.screenWidth,
          isActive: widget.direction == Direction.bottom,
          isExcite: widget.isExcite
        ),
        DirectionCharacterSpeech(
          direction: Direction.left,
          text: widget.text,
          screenWidth: widget.screenWidth,
          isActive: widget.direction == Direction.left,
          isExcite: widget.isExcite
        ),
        DirectionCharacterSpeech(
          direction: Direction.right,
          text: widget.text,
          screenWidth: widget.screenWidth,
          isActive: widget.direction == Direction.right,
          isExcite: widget.isExcite
        ),
      ],
    );
  }
}