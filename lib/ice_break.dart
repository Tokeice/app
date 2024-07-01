import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_nm/result_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'type/Direction.dart';

class IceBreak extends StatefulWidget {
  @override
  _IceBreakState createState() => _IceBreakState();
}

class _IceBreakState extends State<IceBreak> {
  bool _isRecording = false;
  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;

  int _exciteSeconds = 0; // 盛り上がり判定の秒数カウント用
  int _score = 0; // スコアの秒数カウント用
  Timer? _timer; // 盛り上がり判定の秒数カウント用タイマー
  final int _threshold = 60; // 盛り上がり判定の閾値(dB)

  String theme = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadTheme();
    start();
    _score = 0;
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }

  void onData(NoiseReading noiseReading) =>
      setState(() => _latestReading = noiseReading);

  void onError(Object error) {
    print(error);
    stop();
  }

  /// マイクの使用許可を確認する関数
  Future<bool> checkPermission() async => await Permission.microphone.isGranted;

  /// マイクの使用許可をリクエストする関数
  Future<void> requestPermission() async =>
      await Permission.microphone.request();

  /// ノイズメーターのサンプリングを開始
  Future<void> start() async {
    // ノイズメーターの初期化
    noiseMeter ??= NoiseMeter();

    // マイクの使用許可を確認
    if (!(await checkPermission())) await requestPermission();

    // ノイズメーターのサンプリングを開始
    _noiseSubscription = noiseMeter?.noise.listen(onData, onError: onError);
    setState(() => _isRecording = true);
  }

  /// ノイズメーターのサンプリングを停止
  void stop() {
    _noiseSubscription?.cancel();
    setState(() => _isRecording = false);
  }

  /// トークテーマの読み込み
  Future<void> _loadTheme() async {
    String jsonString = await rootBundle.loadString('assets/topics.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    setState(() {
      theme = jsonData['theme'];
    });
  }

  void _startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _exciteSeconds++; // 盛り上がり判定の秒数の加算
          _score++; // スコアの加算
        });
      });
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _exciteSeconds = 0;
  }

  Color changeBackground() {
    if (!_isRecording) {
      // 録音フラグがfalseの場合
      return Colors.white;
    } else if ((_latestReading?.meanDecibel ?? 0) > _threshold) {
      // 音が一定のdBより大きい
      _startTimer();

      if (_exciteSeconds >= 5) {
        // 一定のdBより大きい状態が5秒以上続く
        return Color.fromARGB(0xFF, 0xFE, 0xBB, 0xAC);
      }
    } else {
      _stopTimer();
    }
    return Color.fromARGB(0xFF, 0x6B, 0xA9, 0xE2);
  }

  GestureDetector changeEndButton(double screenWidth) {
    if ((_latestReading?.meanDecibel ?? 0) > _threshold) {
      // 音が一定のdBより大きい

      if (_exciteSeconds >= 5) {
        // 一定のdBより大きい状態が5秒以上続く
        return GestureDetector(
          child: SvgPicture.asset(
            'images/button_end_excite.svg',
            width: screenWidth * 0.4,
          ),
          onTap: () {
            stop();
            Navigator.push(
              context,
               MaterialPageRoute(builder: (context) => ResultScreen(score: _score)),
            );
          },
        );
      }
    }
    return GestureDetector(
      child: SvgPicture.asset(
        'images/button_end_silent.svg',
        width: screenWidth * 0.4,
      ),
      onTap: () {
        stop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(score: _score,)),
        );
      },
    );
  }

  /// 吹き出し
  Widget speechBubbleWidget(BuildContext context, Direction direction, String text) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    double scaleX = 1.0;
    double scaleY = 1.0;
    switch (direction) {
      case Direction.top:
      case Direction.bottom:
        scaleX = 1.0;
        scaleY = 1.3;
        break;
      case Direction.left:
      case Direction.right:
        scaleX = 1.4;
        scaleY = 1.0;
        break;
    }

    return
      Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scaleX: scaleX,
              scaleY: scaleY,
              child: SvgPicture.asset(
                'images/speech_bubble.svg',
              ),
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ])
      );
  }

  /// キャラクターと吹き出し
  /// direction: キャラクターの向き
  /// text: 吹き出しのテキスト
  Widget directionCharacterSpeechWidget(BuildContext context, Direction direction, String text) {
    double screenWidth = MediaQuery.of(context).size.width;
    Alignment alignment = Alignment.bottomCenter;
    double angle = 0;
    double translateY = screenWidth * 0.173;

    switch (direction) {
      case Direction.top:
        alignment = Alignment.topCenter;
        angle = 3.14159;
        break;
      case Direction.bottom:
        alignment = Alignment.bottomCenter;
        angle = 0;
        break;
      case Direction.left:
        alignment = Alignment.centerRight;
        angle = 3.14159 / 2;
        break;
      case Direction.right:
        alignment = Alignment.centerLeft;
        angle = -3.14159 / 2;
        break;
    }

    return
      Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: Offset(0, translateY),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              speechBubbleWidget(context, direction, text),
              if (direction == Direction.top || direction == Direction.bottom)
                SizedBox(height: screenWidth * 0.1),
              SvgPicture.asset(
                'images/character_normal.svg',
                width: screenWidth * 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column selfIntroArrow(double screenWidth) {
    return Column(
      children: [
        Text(
          '時計回りに',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.1,
            color: Colors.white),
        ),
        SvgPicture.asset(
          'images/arrow_self_introduction.svg',
          width: screenWidth * 0.5,
        ),
      ],
    );
  }

  Transform selfIntroCharactor(double screenWidth) {
    double speechWidth = screenWidth * 0.8;
    double characterWidth = screenWidth * 0.5;
    return Transform.translate(
      offset: Offset(0, screenWidth * 0.13),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'images/speech_bubble_vertical_screen.svg',
                width: speechWidth,
              ),
              Container(
                padding: EdgeInsets.only(bottom: speechWidth * 0.05),
                width: speechWidth,
                child: Text(
                  '君から順番に\n自己紹介して！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.1,
                    color: Colors.black
                  ),
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            'images/character_normal.svg',
            width: characterWidth,
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: changeEndButton(screenWidth)),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  selfIntroArrow(screenWidth),
                  selfIntroCharactor(screenWidth),
                ],
              ),
            )
          ),
          // 以下のコードでキャラクターとトークテーマを表示
          // directionCharacterSpeechWidget(context, Direction.left, theme),
        ],
      ),
      backgroundColor: changeBackground(),
    );
  }
}
