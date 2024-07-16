import 'package:flutter/material.dart';
import 'widget/start_button.dart';
import 'widget/description_image.dart';
import 'widget/app_title.dart';
import 'widget/privacy_policy.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(0xFF, 0xFF, 0xF6, 0xC9),
          fontFamily: 'Zen Maru Gothic' // アプリ全体のフォントの指定
          ),
      home: const TitleScreen(),
    );
  }
}

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  TitleScreenState createState() => TitleScreenState();
}

class TitleScreenState extends State<TitleScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // 画面の幅を取得

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTitle(screenWidth: screenWidth), // 画面上部のアプリタイトル
          DescriptionImage(screenWidth: screenWidth), // アプリの利用方法の説明画像
          StartButton(screenWidth: screenWidth), // アイスブレイクのスタートボタン
          PrivacyPolicy(), // プライバシーポリシーの表示
        ],
      ),
    );
  }
}

