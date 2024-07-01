import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScoreScreenCharacter extends StatelessWidget {
  const ScoreScreenCharacter({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        SvgPicture.asset('images/speech_bubble_result.svg',
            width: screenWidth * 0.5),
        SvgPicture.asset(
          'images/character_with_icecream.svg',
          width: screenWidth * 0.5, 
        ),
      ],
    );
  }
}
