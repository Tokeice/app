import 'dart:async';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class IceBreak extends StatefulWidget {
  @override
  _IceBreakState createState() => _IceBreakState();
}

class _IceBreakState extends State<IceBreak> {
  bool _isRecording = false;
  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;

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

  /// ノイズメーターのサンプリングを停止
  void stop() {
    _noiseSubscription?.cancel();
    setState(() => _isRecording = false);
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
                child: Text(_isRecording ? "Mic: ON" : "Mic: OFF",
                    style: TextStyle(fontSize: 25, color: Colors.blue)),
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
              )
            ]),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: _isRecording ? Colors.red : Colors.green,
      child: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic),
      onPressed: _isRecording ? stop : start,
    ),
  );
}
