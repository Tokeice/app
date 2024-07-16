import 'dart:async';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_nm/result_screen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'widget/end_button.dart';
import 'widget/character_speech.dart';
import 'type/IceBreakState.dart';
import 'utils/select_topics.dart';
import 'utils/select_direction.dart';

class IceBreak extends StatefulWidget {
  IceBreak({required this.threshold});
  final int threshold;

  @override
  _IceBreakState createState() => _IceBreakState();
}

class _IceBreakState extends State<IceBreak> {
  // ノイズメーター関連の変数
  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;

  int _silentSeconds = 0; // 沈黙判定の秒数カウント用
  late int _score; // スコア
  Timer? _timer; // タイマー
  late int _threshold; // 盛り上がり判定の閾値(dB)
  late IceBreakState _state;

  SelectTopic selector = SelectTopic(jsonPath: 'assets/topics.json');
  SelectDirection direction = SelectDirection();

  @override
  void initState() {
    super.initState();
    initialize();
    WakelockPlus.enable();
  }

  Future<void> initialize() async {
    await selector.loadTheme();
    setState(() {
      _threshold = widget.threshold;
      selector.select();
      direction.select();
      _score = 0;
      _state = IceBreakState.normal;
    });
    _startNoiseMeter();
    _startTimer();
  }

  @override
  void dispose() {
    _stopNoiseMeter();
    _timer?.cancel();
    super.dispose();
    WakelockPlus.disable();
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
  }

  /// ノイズメーターのサンプリングを停止
  void _stopNoiseMeter() {
    _noiseSubscription?.cancel();
    _noiseSubscription = null;
  }

  /// タイマーの開始
  void _startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if ((_latestReading?.meanDecibel ?? 0) > _threshold) {
          // 音量が閾値より大きい
          setState(() {
            _score++; // スコアの秒数の加算
            _silentSeconds = 0; // 沈黙判定の秒数のリセット
          });
        } else {
          setState(() {
            _silentSeconds++; // 沈黙判定の秒数の加算
          });
        }

        if (_silentSeconds == 0) {
          setState(() {
            _state = IceBreakState.excite;
          });
        } else {
          setState(() {
            _state = IceBreakState.silent;
          });
        }

        if (5 <= _silentSeconds) {
          setState(() {
            direction.select();
            selector.select();
            _silentSeconds = -5;
          });
        }

      });
    }
  }

  /// タイマーの停止
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _silentSeconds = 0;
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
            selector.getTopic() == '' ? Container() : 
            CharacterSpeech(direction: direction.get(), text: selector.getTopic(), screenWidth: screenWidth, isExcite: _state == IceBreakState.excite)
          ],
        ),
      )
    );
  }
}
