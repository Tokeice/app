import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // 画面の幅を取得

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'images/character_normal.svg',
                width: screenWidth * 0.5, // 画像の幅を画面幅の50%に指定
              ),
            ),
            
            Container(
              child: ElevatedButton(
                child: Text('スタート'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IceBreak()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
