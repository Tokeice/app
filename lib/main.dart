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
      home: IceBreakTitle(),
    );
  }
}

class IceBreakTitle extends StatefulWidget {
  @override
  _IceBreakState createState() => _IceBreakState();
}

class _IceBreakState extends State<IceBreakTitle> {
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