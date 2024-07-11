import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    super.key,
    required this.screenWidth,
    required this.onPressed,
  });

  final double screenWidth;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: IconButton (
        icon: const Icon(Icons.settings),
        onPressed: onPressed,
      ),
    );
  }
}