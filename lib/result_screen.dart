import 'package:flutter/material.dart';
import 'main.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      // 画面遷移のボタン
      child: ElevatedButton(
        child: Text('スタート画面に戻る'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TitleScreen()),
          );
        },
      ),
    ),
  );
}
