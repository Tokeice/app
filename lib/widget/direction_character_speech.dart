import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_nm/type/Direction.dart';
import 'package:flutter_svg/svg.dart';
import 'speech_bubble.dart';

/// 方向を指定してキャラクターを表示する
/// direction: キャラクターの向き
/// text: 吹き出しのテキスト
class DirectionCharacterSpeech extends StatefulWidget {
  final Direction direction;
  final String text;
  final double screenWidth;
  final bool isActive;

  const DirectionCharacterSpeech({
    super.key,
    required this.direction,
    required this.text,
    required this.screenWidth,
    required this.isActive,
  });
  
  @override
  DirectionCharacterSpeechState createState() => DirectionCharacterSpeechState();
}

class DirectionCharacterSpeechState extends State<DirectionCharacterSpeech> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isActive) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant DirectionCharacterSpeech oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      if (widget.isActive) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Alignment alignment;
    double angle = 0;
    double translateY = widget.screenWidth * 0.173;

    switch (widget.direction) {
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
        child: SlideTransition(
          position: _offsetAnimation,
          child: Transform.translate(
            offset: Offset(0, translateY),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpeechBubble(direction: widget.direction, text: widget.text),
                if (widget.direction == Direction.top || widget.direction == Direction.bottom)
                  SizedBox(height: widget.screenWidth * 0.1),
                SvgPicture.asset(
                  'images/character_normal.svg',
                  width: widget.screenWidth * 0.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
