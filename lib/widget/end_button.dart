import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../type/IceBreakState.dart';

class EndButton extends StatelessWidget {
  final double screenWidth;
  final IceBreakState state;
  final Function onTap;

  const EndButton({
    super.key,
    required this.screenWidth,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double offsetX = state == IceBreakState.excite ? screenWidth * 0.1 : screenWidth * 0.05;
    double offsetY = state == IceBreakState.excite ? -screenWidth * 0.1 : -screenWidth * 0.02;
    double imageWidth = state == IceBreakState.excite ? screenWidth * 0.45 : screenWidth * 0.35;
    String imageName = state == IceBreakState.excite ? 'images/button_end_excite.svg' : 'images/button_end_silent.svg';

    return GestureDetector(
      onTap: onTap as void Function(),
      child: Transform.translate(
        offset: Offset(offsetX, offsetY),
        child: SvgPicture.asset(
          imageName,
          width: imageWidth,
        )
      ),
    );
  }
}