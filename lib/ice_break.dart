import 'dart:async';
import 'dart:convert';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_nm/result_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

import 'widget/end_button.dart';
import 'widget/character_speech.dart';
import 'type/IceBreakState.dart';
import 'package:test_nm/type/Direction.dart';
import 'widget/icebreak_character.dart';
import 'utils/select_topics.dart';

class IceBreak extends StatefulWidget {
  @override
  _IceBreakState createState() => _IceBreakState();
}

class _IceBreakState extends State<IceBreak> {
  // ノイズメーター関連の変数
  bool _isRecording = false;
  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;

  int _exciteSeconds = 0; // 盛り上がり判定の秒数カウント用
  int _score = 0; // スコア
  Timer? _timer; // タイマー
  final int _threshold = 60; // 盛り上がり判定の閾値(dB)
  IceBreakState _state = IceBreakState.normal;

  String _theme = "Loading...";
  SelectTopic selecter = SelectTopic(jsonPath: 'assets/topics.json');
  String topic ='Loading...';
  bool isSelected = false;
  late Direction direction;

  @override
  void initState() {
    super.initState();
    _startNoiseMeter();
    _startTimer();
    selecter.loadTheme();
    _score = 0;
    _state = IceBreakState.normal;
  }

  @override
  void dispose() {
    _stopNoiseMeter();
    _timer?.cancel();
    super.dispose();
  }

  void onData(NoiseReading noiseReading) =>
      setState(() => _latestReading = noiseReading);

  void onError(Object error) {
    debugPrint(error.toString());
    _stopNoiseMeter();
    _stopTimer();
  }

  /// マイクの使用許可を確認する関数
  Future<bool> checkPermission() async => await Permission.microphone.isGranted;

  /// マイクの使用許可をリクエストする関数
  Future<void> requestPermission() async =>
      await Permission.microphone.request();

  /// ノイズメーターのサンプリングを開始
  Future<void> _startNoiseMeter() async {
    // ノイズメーターの初期化
    noiseMeter ??= NoiseMeter();

    // マイクの使用許可を確認
    if (!(await checkPermission())) await requestPermission();

    // ノイズメーターのサンプリングを開始
    _noiseSubscription = noiseMeter?.noise.listen(onData, onError: onError);
    setState(() => _isRecording = true);
  }

  /// ノイズメーターのサンプリングを停止
  void _stopNoiseMeter() {
    _noiseSubscription?.cancel();
    setState(() => _isRecording = false);
  }

  /// タイマーの開始
  void _startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if ((_latestReading?.meanDecibel ?? 0) > _threshold) {
          // 音量が閾値より大きい
          setState(() {
            _exciteSeconds++; // 盛り上がり判定の秒数の加算
            _score++; // スコアの秒数の加算
          });
        } else {
          setState(() {
            _exciteSeconds = 0; // 盛り上がり判定の秒数のリセット
          });
        }

        if (_isRecording == false) {
          setState(() {
            _state = IceBreakState.normal;
          });
        } else if (_exciteSeconds >= 5) {
          setState(() {
            _state = IceBreakState.excite;
          });
        } else {
          setState(() {
            _state = IceBreakState.silent;
          });
        }

        if (_exciteSeconds % 10 == 0) {
          int rand = Random().nextInt(4); 
          direction = Direction.values[rand];
        }

      });
    }
  }

  /// タイマーの停止
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _exciteSeconds = 0;
  }

 /// おわるボタンをタップしたときの処理
  void onTapEndButton() {
    _stopNoiseMeter();
    _stopTimer();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultScreen(score: _score)),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: _state == IceBreakState.excite ? const Color.fromARGB(0xFF, 0xFE, 0xBB, 0xAC) : _state == IceBreakState.silent ? const Color.fromARGB(0xFF, 0x6B, 0xA9, 0xE2) : Colors.white,
        child: Stack(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: EndButton(screenWidth: screenWidth, state: IceBreakState.excite, onTap: onTapEndButton, isActive: _state == IceBreakState.excite),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: EndButton(screenWidth: screenWidth, state: IceBreakState.silent, onTap: onTapEndButton, isActive: _state != IceBreakState.excite),
                ),
              ],
            ),
            CharacterSpeech(direction: direction, text: _theme, screenWidth: screenWidth)
          ],
        ),
      )
    );
  }
}
