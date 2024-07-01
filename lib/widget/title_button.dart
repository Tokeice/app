import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_nm/main.dart';

class TitleButton extends StatelessWidget {
  const TitleButton({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TitleScreen()),
          );
        },
        child: SvgPicture.asset(
            'images/button_back_to_title.svg',
            width: screenWidth * 0.8,
          ),
        
    );
  }
}
