import 'dart:async';
import 'dart:convert';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_nm/result_screen.dart';
import 'package:flutter/services.dart' show rootBundle;

class IceBreak extends StatefulWidget {
  @override
  _IceBreakState createState() => _IceBreakState();
}

class _IceBreakState extends State<IceBreak> {

  bool _isRecording = false;
  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;

  int _seconds = 0; // 沈黙判定の秒数カウント用
  Timer? _timer; // 沈黙判定の秒数カウント用
  final int _threshold = 60; // 沈黙判定の閾値(dB)

  String theme = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadTheme();
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

  /// サンプリングを開始
  Future<void> start() async {
    // ノイズメーターの初期化
    noiseMeter ??= NoiseMeter();

    // マイクの使用許可を確認
    if (!(await checkPermission())) await requestPermission();

    // ノイズメーターのサンプリングを開始
    _noiseSubscription = noiseMeter?.noise.listen(onData, onError: onError);
    setState(() => _isRecording = true);
  }

  Future<void> _loadTheme() async {
    String jsonString = await rootBundle.loadString('assets/topics.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    setState(() {
      theme = jsonData['theme'];
    });
  }

  /// ノイズメーターのサンプリングを停止
  void stop() {
    _noiseSubscription?.cancel();
    setState(() => _isRecording = false);
  }

  void _startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _seconds = 0;
  }

  Color changeBackground() {
    if (!_isRecording) { // 録音フラグがfalseの場合
      return Colors.white;
    }
    else if ((_latestReading?.meanDecibel ?? 0 ) > _threshold){ // 音が一定のdBより大きい
      _startTimer();

      if (_seconds >= 5){ // 一定のdBより大きい状態が5秒以上続く
        return Colors.red;
      }
    }else {
      _stopTimer();
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(25),
            child: Column(children: [
              Container(
                child: Text('Theme: $theme',
                  style: TextStyle(fontSize: 25, color: Colors.black)),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(_isRecording ? "Mic: ON" : "Mic: OFF",
                  style: TextStyle(fontSize: 25, color: Colors.black)),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  'Noise: ${_latestReading?.meanDecibel.toStringAsFixed(2)} dB',
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  'Max: ${_latestReading?.maxDecibel.toStringAsFixed(2)} dB',
                ),
              ),
              ElevatedButton(
                onPressed: _isRecording ? stop : start,
                child: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic),
              )
            ]),
          ),
        ],
      ),
    ),
    backgroundColor: changeBackground(),
    floatingActionButton: FloatingActionButton(
      child: Text('終了'),
      onPressed: () {
        stop;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen()),
        );
      },
    ),
  );
}
