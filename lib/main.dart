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
          scaffoldBackgroundColor: Color.fromARGB(0xFF, 0xFF, 0xF6, 0xC9),
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
    double screenHeight = MediaQuery.of(context).size.height; // 画面の高さを取得

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      child: SvgPicture.asset('images/title_background.svg',
                          width: screenWidth,
                          // height: screenHeight * 0.3,
                          fit: BoxFit.fill),
                    ),
                    Positioned(
                      child: SvgPicture.asset(
                        'images/app_name.svg',
                        width: screenWidth * 0.9,
                      ),
                    )
                  ],
                )),
            Container(
              child: SvgPicture.asset(
                'images/description.svg',
                width: screenWidth * 0.8, // 画像の幅を画面幅の50%に指定
              ),
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IceBreak()),
                  );
                },
                child: SvgPicture.asset(
                  'images/button_start_ice_break.svg',
                  width: screenWidth * 0.8,
                ),
              ),
            ),
            SizedBox(
              height: screenWidth * 0.001,
            )
          ],
        ),
      ),
    );
  }
}
