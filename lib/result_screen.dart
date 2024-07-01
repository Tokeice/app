import 'package:flutter/material.dart';
import 'widget/score.dart';
import 'widget/score_screen_character.dart';
import 'widget/title_button.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  const ResultScreen({super.key, required this.score});

  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Score(screenWidth: screenWidth, score: widget.score), // スコア
            ScoreScreenCharacter(screenWidth: screenWidth), // キャラクターと吹き出し
            TitleButton(screenWidth: screenWidth), // タイトルに戻るボタン
          ],
        ),
      ),
    );
  }
}
