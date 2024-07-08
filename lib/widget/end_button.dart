import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../type/IceBreakState.dart';

class EndButton extends StatefulWidget {
  final double screenWidth;
  final IceBreakState state;
  final Function onTap;
  final bool isActive;

  const EndButton({
    super.key,
    required this.screenWidth,
    required this.state,
    required this.onTap,
    required this.isActive,
  });

  @override
  EndButtonState createState() => EndButtonState();
}

class EndButtonState extends State<EndButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
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
  void didUpdateWidget(covariant EndButton oldWidget) {
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
    double offsetX = widget.state == IceBreakState.excite ? widget.screenWidth * 0.1 : widget.screenWidth * 0.05;
    double offsetY = widget.state == IceBreakState.excite ? -widget.screenWidth * 0.1 : -widget.screenWidth * 0.02;
    double imageWidth = widget.state == IceBreakState.excite ? widget.screenWidth * 0.45 : widget.screenWidth * 0.35;
    String imageName = widget.state == IceBreakState.excite ? 'images/button_end_excite.svg' : 'images/button_end_silent.svg';

    return SlideTransition(
      position: _offsetAnimation,
      child: GestureDetector(
        onTap: widget.onTap as void Function(),
        child: Transform.translate(
          offset: Offset(offsetX, offsetY),
          child: SvgPicture.asset(
            imageName,
            width: imageWidth,
          ),
        ),
      ),
    );
  }
}
