import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../ice_break.dart';

// タイトルのアイスブレイクスタートボタン
class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Center (
      child: InkResponse (
        onTap: () {
          Future.delayed(
            const Duration(milliseconds: 100),
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IceBreak()),
            ),
          );
        },
        child: SvgPicture.asset(
          'images/button_start_ice_break.svg',
          width: screenWidth * 0.8,
        ),
      )
    );
  }
}