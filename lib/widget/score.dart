import 'package:flutter/material.dart';


class Score extends StatelessWidget {
  const Score({
    super.key,
    required this.screenWidth,
    required this.score,
  });

  final double screenWidth;
  final int score;

  // スコアを計算
  String calcScore() {
    String minutesStr = (score ~/ 60).toString().padLeft(2, ' ');
    String secondsSrt = (score % 60).toString().padLeft(2, '0');

    return '$minutesStr分$secondsSrt秒';
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        calcScore(),
        style: TextStyle(
          fontSize: screenWidth * 0.1,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(0xFF, 0x41, 0x64, 0x98)),
      ),
      Text(
        '盛り上がりました！',
        style: TextStyle(
          fontSize: screenWidth * 0.1,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(0xFF, 0x14, 0x25, 0x40)),
      )
    ]);
  }
}