import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// スタート画面の説明画像
class DescriptionImage extends StatelessWidget {
  const DescriptionImage({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset( // スタート画面の説明画像を表示
      'images/description.svg',
      width: screenWidth * 0.8,
    );
  }
}