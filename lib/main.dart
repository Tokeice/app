import 'dart:async';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'ice_break.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Zen Maru Gothic' // アプリ全体のフォントの指定
      ),
      home: TitleScreen(),
    );
  }
}

class TitleScreen extends StatefulWidget {
  @override
  _TitleScreenState createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      // 画面遷移のボタン
      child: ElevatedButton(
        child: Text('スタート'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IceBreak()),
          );
        },
      ),
    ),
  );
}