import 'package:flutter/material.dart';
import 'widget/start_button.dart';
import 'widget/description_image.dart';
import 'widget/app_title.dart';
import 'widget/setting_button.dart';


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
  
  // 閾値の設定
  int threshold = 70;
  void _openSettingsModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('環境音設定'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('現在の環境音: $threshold dB'),
              const SizedBox(height: 10), // 余白を追加
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "ここに設定したい値を入力"),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('決定'),
              onPressed: () {
                setState(() {
                  threshold = int.tryParse(controller.text) ?? 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // 画面の幅を取得

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTitle(screenWidth: screenWidth), // 画面上部のアプリタイトル
          DescriptionImage(screenWidth: screenWidth), // アプリの利用方法の説明画像
          StartButton(screenWidth: screenWidth, threshold: threshold), // アイスブレイクのスタートボタン
          SettingButton(screenWidth: screenWidth, onPressed: () => _openSettingsModal(context)), // 設定ボタン
        ],
      ),
    );
  }
}

