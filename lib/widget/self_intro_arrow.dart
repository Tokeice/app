import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelfIntroArrow extends StatelessWidget {
  const SelfIntroArrow({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
          return Column(
        children: [
          Text(
            '時計回りに',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.1,
                color: Colors.white),
          ),
          SvgPicture.asset(
            'images/arrow_self_introduction.svg',
            width: screenWidth * 0.5,
          ),
        ],
      );
    }
  }