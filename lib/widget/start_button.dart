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
    return GestureDetector(
      onTap: () { // svg画像がタップされたらアイスブレイク画面に遷移
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IceBreak()),
        );
      },
      child: SvgPicture.asset( // ボタンのsvg画像を表示
        'images/button_start_ice_break.svg',
        width: screenWidth * 0.8,
      ),
    );
  }
}