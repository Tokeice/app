import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// スタート画面に表示するアプリ名
class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          child: SvgPicture.asset(
              'images/title_background.svg',
              width: screenWidth, fit: BoxFit.fill),
        ),
        Positioned(
          child: SvgPicture.asset(
            'images/app_name.svg',
            width: screenWidth * 0.9,
          ),
        )
      ],
    );
  }
}
