import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Duration duration;
  final bool isActive;

  const AnimatedText({
    super.key,
    required this.text,
    required this.style,
    required this.textAlign,
    this.duration = const Duration(milliseconds: 100),
    this.isActive = true,
  });

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  String _displayedText = '';
  int _currentIndex = 0;
  Timer? _timer;
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _opacityController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_opacityController);

    if (widget.isActive) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      if (widget.isActive) {
        _opacityController.reverse();
        _resetAnimation();
        _startAnimation();
      } else {
        _opacityController.forward();
      }
    }
  }

  void _resetAnimation() {
    setState(() {
      _displayedText = '';
      _currentIndex = 0;
    });
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1000)); // Initial delay
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_currentIndex];
          _currentIndex++;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Text(
        _displayedText,
        style: widget.style,
        textAlign: widget.textAlign,
      ),
    );
  }
}
