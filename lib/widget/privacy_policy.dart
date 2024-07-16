import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  final Uri _url = Uri.parse('https://tokeice-1d760.web.app/');

  void _launchURL() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // 画面右下にプライバシーポリシーへのリンクを表示
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.bottomLeft,
      child: TextButton(
        onPressed: () {
          _launchURL();
        },
        child: const Text(
          'プライバシーポリシー',
          style: TextStyle(
            color: Color.fromARGB(255, 51, 55, 80),
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}